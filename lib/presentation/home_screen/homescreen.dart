import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/view_model/category_cubit/category_cubit.dart';
import 'package:shop_app/view_model/home_cubit/home_cubit.dart';
import 'package:shop_app/view_model/home_cubit/home_states.dart';
import '../../data/models/categories/category_model.dart';
import '../../data/models/home/home_model.dart';
import '../../widgets/component/components.dart';

class HomeScreen extends StatelessWidget {
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(listener: (context, state) {
      controller.addListener(() {
        closeTopContainer = controller.offset > 50;
      });
    }, builder: (context, state) {
      var cubit = HomeCubit.get(context);
      return ConditionalBuilder(
        condition: cubit.homeModel != null &&
            CategoryCubit.get(context).categoryModel != null,
        builder: (context) => productsbuilder(cubit.homeModel!, context,
            CategoryCubit.get(context).categoryModel!),
        fallback: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }

  Widget productsbuilder(
      HomeModel homeModel, context, CategoryModel categoryModel) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: homeModel.data!.banners
                .map(
                  (e) => Image(
                    image: NetworkImage(
                      '${e.image}',
                    ),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 250,
              initialPage: 0,
              reverse: false,
              autoPlay: true,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              autoPlayInterval: const Duration(
                seconds: 3,
              ),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  alignment: AlignmentDirectional.topCenter,
                  height: closeTopContainer ? 0 : 100,
                  child: Container(
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          buildCategoryItem(categoryModel.data!.data[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10,
                      ),
                      itemCount: categoryModel.data!.data.length,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                const Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              controller: controller,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1 / 1.7,
              children: List.generate(
                homeModel.data!.products.length,
                (index) =>
                    buildGridProduct(homeModel.data!.products[index], context),
              ),
            ),
          ),
        ],
      ),
    );
  }


}
