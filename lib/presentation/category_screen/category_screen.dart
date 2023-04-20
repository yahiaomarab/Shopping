import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/view_model/category_cubit/category_cubit.dart';
import 'package:shop_app/view_model/category_cubit/category_states.dart';
import '../../data/models/categories/category_model.dart';
import '../../widgets/component/components.dart';
import 'catProduct_screen.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CategoryCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  catitem(cubit.categoryModel!.data!.data[index], context),
              separatorBuilder: (context, index) => devidorLine(),
              itemCount: cubit.categoryModel!.data!.data.length,
            ),
          );
        });
  }

  Widget catitem(DataModel model, context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage('${model.image}'),
            height: 100,
            width: 100,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            '${model.name}',
            style: const TextStyle(
              fontSize: 25,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              CategoryCubit.get(context).getCatData(model.id);
              navTo(context, CategoryProductsScreen(model.name,model.id));
            },
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
