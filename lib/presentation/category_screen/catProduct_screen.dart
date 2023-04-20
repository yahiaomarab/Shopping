import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/presentation/cart_screen/carts_screen.dart';
import 'package:shop_app/view_model/category_cubit/category_cubit.dart';
import 'package:shop_app/view_model/category_cubit/category_states.dart';
import 'package:shop_app/view_model/favourite_cubit/favourite_cubit.dart';
import 'package:shop_app/widgets/component/components.dart';
import '../../data/models/categories/cat_model.dart';
import '../../view_model/cart_cubit/cart_cubit.dart';
import '../../view_model/cart_cubit/cart_states.dart';
import '../product_screen/product_screen.dart';
import '../search_screen/search_screen.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String? name;
  final int? id;
  CategoryProductsScreen(this.name, this.id);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        CategoryCubit.get(context).getCategoriesData();
        CategoryCubit.get(context).getCatData(id);
        return BlocConsumer<CartCubit, CartStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('$name'),
                  actions: [
                    Center(
                      child: IconButton(
                        onPressed: () {
                          navTo(context, SearchScreen());
                        },
                        icon: const Icon(
                          Icons.search,
                          size: 32,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Center(
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.shopping_cart_outlined,
                                size: 30,
                                color: Colors.black54,
                              ),
                              onPressed: () {
                                navTo(context, CartsScreen());
                              },
                            ),
                            if (CartCubit.get(context)
                                    .cartsModel
                                    ?.data
                                    ?.cartItems !=
                                null)
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    bottom: 6.5, end: 6.5),
                                child: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 7,
                                  child: Text(
                                    '${CartCubit.get(context).cartsModel?.data?.cartItems!.length}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 8, color: Colors.white),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                body: ConditionalBuilder(
                  condition:
                      CategoryCubit.get(context).getCategoriesData() != null &&
                          CategoryCubit.get(context).getCatData(id) != null &&
                          CategoryCubit.get(context).categoryProducts != null &&
                          state is! GettingCategoriesDataLoading,
                  builder: (context) => SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1 / 1.7,
                          children: List.generate(
                              CategoryCubit.get(context)
                                  .categoryProducts!
                                  .data!
                                  .data!
                                  .length,
                              (index) => buildProductView(
                                  CategoryCubit.get(context)
                                      .categoryProducts
                                      ?.data
                                      ?.data![index],
                                  context)),
                        ),
                      ],
                    ),
                  ),
                  fallback: (context) =>
                      const Center(child: CircularProgressIndicator()),
                ),
              );
            });
      },
    );
  }

  Widget buildProductView(CategoryProductsDataData? model, context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.0),
        child: Material(
          elevation: 1.2,
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: () {
              CategoryCubit.get(context).getCatData(model!.id);
              navTo(context, ProductScreen( model.id,));
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(
                              height: 210,
                              width: double.infinity,
                              image: NetworkImage('${model!.image}'),
                            ),
                          ),
                          if (model.discount!.round() != 0)
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.red,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0,
                                ),
                                child: Text(
                                  'Discount ${model.discount!.round()}%',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Center(
                        child: Text(
                          model.name.toString(),
                          style: const TextStyle(height: 1.3),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  devidorLine(),
                  Expanded(
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${model.price!.round()} EGP',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: HexColor('10BD70'),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        if (model.discount!.round() != 0)
                          Text(
                            '${model.oldPrice!.round()}',
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.redAccent,
                            ),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            FavouriteCubit.get(context)
                                .changeProductFavourite(model.id!);
                          },
                          highlightColor: Colors.transparent,
                          icon: FavouriteCubit.get(context)
                                      .FavoritesProducts[model.id] ==
                                  true
                              ? Icon(
                                  Icons.favorite,
                                  size: 25,
                                  color: HexColor('4C4E4D'),
                                )
                              : Icon(
                                  Icons.favorite_border_outlined,
                                  size: 25,
                                  color: HexColor('4C4E4D'),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
