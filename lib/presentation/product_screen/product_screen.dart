import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/view_model/product_cubit/product_states.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../data/models/product/product_model.dart';
import '../../view_model/cart_cubit/cart_cubit.dart';
import '../../view_model/favourite_cubit/favourite_cubit.dart';
import '../../view_model/product_cubit/product_cubit.dart';
import '../../widgets/component/components.dart';
import '../../widgets/styles/colors/colors.dart';
import '../cart_screen/carts_screen.dart';
import '../search_screen/search_screen.dart';

class ProductScreen extends StatelessWidget {
  final productId;

  ProductScreen(this.productId);

  List<NetworkImage> images = [];
  var productImages = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>ProductCubit()..getProductData(productId),
      child: BlocConsumer<ProductCubit, ProductStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: const Text('Shop App'),
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
              floatingActionButton: ConditionalBuilder(
                condition: state is! GettingProductDataLoading &&
                    state is! GettingProductDataError,
                builder: (context) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100.0, vertical: 6.0),
                    child:
                        CartCubit.get(context).inCartsRealTime[productId] != true
                            ? defaultButton(
                                function: () {
                                  CartCubit.get(context).changeCarts(productId);
                                },
                                text: 'Add To Carts',
                                icon: Icons.add_shopping_cart,
                                radius: 20,
                              )
                            : defaultButton(
                                function: () {
                                  navTo(context, CartsScreen());
                                },
                                text: 'Checkout In Carts',
                                icon: Icons.shopping_cart,
                                background: Colors.red,
                                radius: 20,
                              )),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.miniCenterFloat,
              body: ConditionalBuilder(
                condition:
                    ProductCubit.get(context).productDetails?.data != null &&
                        state is! GettingProductDataLoading,
                builder: (context) => ConditionalBuilder(
                  condition: state is! GettingProductDataError,
                  builder: (context) => buildProduct(
                      context, ProductCubit.get(context).productDetails!.data),
                  fallback: (context) => const Center(
                      child: Text(
                    'Please check your internet and try again',
                    style: TextStyle(color: Colors.grey, fontSize: 17),
                  )),
                ),
                fallback: (context) => const Center(
                  child: RefreshProgressIndicator(),
                ),
              ),
            );
          }),
    );
  }

  Widget buildProduct(context, ProductDetailsData? model) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Text(
              '${model!.name}',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Material(
              elevation: 0.7,
              color: Colors.white,
              borderRadius: BorderRadius.circular(35),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SizedBox(
                        height: 200,
                        child: PageView.builder(
                            physics: const BouncingScrollPhysics(),
                            controller: productImages,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Image(
                                  image: NetworkImage(
                                    '${model.images![index]}',
                                  ),
                                ),
                            itemCount: model.images!.length),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SmoothPageIndicator(
                            controller: productImages,
                            count: model.images!.length,
                            effect: const ExpandingDotsEffect(
                              activeDotColor:
                                  defaultColor, //HexColor('2BD596'),
                              dotWidth: 12,
                              dotHeight: 12,
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${model.price} EGP',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 25,
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
                          fontSize: 20,
                        ),
                      ),
                    const Spacer(),
                    // IconButton(
                    //   icon: Icon(Icons.add_shopping_cart_outlined,
                    //       size: 27,
                    //     color: HexColor('1A925D')), onPressed: () {  },
                    // ),
                    IconButton(
                      onPressed: () {
                        FavouriteCubit.get(context)
                            .changeProductFavourite(model.id!);
                      },
                      highlightColor: Colors.transparent,
                      icon: FavouriteCubit.get(context)
                                  .FavoritesProducts[productId] ==
                              true
                          ? Icon(
                              Icons.favorite,
                              size: 30,
                              color: HexColor('4C4E4D'),
                            )
                          : Icon(
                              Icons.favorite_border_outlined,
                              size: 30,
                              color: HexColor('4C4E4D'),
                            ),
                    ),
                  ],
                ),
                if (model.discount!.round() != 0)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${model.discount!.round()}% OFF',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w100),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: devidorLine(),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Description:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                Text('${model.description}'),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
