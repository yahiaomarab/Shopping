import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/view_model/cart_cubit/cart_states.dart';
import 'package:shop_app/widgets/component/components.dart';
import '../../data/models/carts/cart_model.dart';
import '../../view_model/cart_cubit/cart_cubit.dart';
import '../../widgets/styles/colors/colors.dart';

class CartsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartStates>(listener: (context, state) {
      if (state is ChangingCartSuccessState) {
        toastMessage(
            message: '${state.inCartsModel!.message}',
            state: ToastState.success);
      }
    }, builder: (context, state) {
      var cubit = CartCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Cart'),
        ),
        bottomNavigationBar: cubit.cartsModel?.data?.cartItems != null
            ? BottomAppBar(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (cubit.cartsModel?.data?.cartItems != null)
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Total Price:',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 17,
                                  height: 1,
                                ),
                              ),
                              Text(
                                '${cubit.cartsModel!.data!.total} EGP',
                                style: TextStyle(
                                  color: HexColor('10BD70'),
                                  fontSize: 18,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: defaultColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 0.5,
                                    blurRadius: 2,
                                    offset: const Offset(0, 2),
                                  ),
                                ]),
                            child: MaterialButton(
                              onPressed: () {},
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: const Text(
                                'Checkout',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : null,
        body: SizedBox(
            height: double.infinity,
            child: ConditionalBuilder(
              condition: cubit.cartsModel?.data?.cartItems != null,
              builder: (context) => ConditionalBuilder(
                condition: cubit.cartsModel!.data!.total != 0,
                builder: (context) => cartsList(cubit.cartsModel, state),
                fallback: (context) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SizedBox(
                          width: 200,
                          height: 150,
                          child: Image.asset(
                            'assets/images/login.svg',
                          ),
                        ),
                      ),
                      const Text(
                        'Your cart is empty',
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                ),
              ),
              fallback: (context) {
                return Center(
                  child: Column(
                    children: [
                      LinearProgressIndicator(
                        backgroundColor: defaultColor.withOpacity(0.6),
                      ),
                    ],
                  ),
                );
              },
            )),
      );
    });
  }

  Widget cartsList(InCartsModel? inCartsModel, state) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (state is UpdatingCartLoadingState ||
              state is GettingCartLoadingState)
            LinearProgressIndicator(
              backgroundColor: defaultColor.withOpacity(0.6),
            ),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => cartsBuilder(
                  CartCubit.get(context).cartsModel!.data!.cartItems![index],
                  context),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 2,
                  ),
              itemCount: inCartsModel!.data!.cartItems!.length),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  Widget cartsBuilder(InCartsModelDataCartItems? model, context) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          elevation: 1,
          child: InkWell(
            onTap: () {
              // HomeCubit.get(context).getHomeProductData();
              //navTo(context, ProductScreen(model:model.product));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          SizedBox(
                            width: 100.0,
                            height: 100.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                image: NetworkImage('${model!.product!.image}'),
                              ),
                            ),
                          ),
                          if (model.product!.discount!.round() != 0)
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
                                  'Discount ${model.product!.discount!.round()}%',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                int quantity = model.quantity!.toInt();
                                CartCubit.get(context)
                                    .updateCarts(model.id, ++quantity);
                              },
                              child: const Text(
                                '+',
                                style: TextStyle(fontSize: 25),
                              )),
                          Text('${model.quantity}'),
                          TextButton(
                              onPressed: () {
                                int quantity = model.quantity!.toInt();
                                if (quantity > 1) {
                                  CartCubit.get(context)
                                      .updateCarts(model.id, --quantity);
                                } else {
                                  CartCubit.get(context)
                                      .updateCarts(model.product!.id, quantity);
                                }
                              },
                              child: const Text(
                                '-',
                                style:
                                    TextStyle(fontSize: 25, color: Colors.red),
                              )),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 150.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              '${model.product!.name}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                          Row(
                            children: const [
                              Text(
                                'Shipping Price: ',
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                'Free',
                                style: TextStyle(
                                    color: defaultColor, fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Price: ',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    '${(model.product!.price!.toInt()) * (model.quantity!.toInt())} EGP',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: defaultColor, fontSize: 14),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  children: [

                                    InkWell(
                                      onTap: () {
                                        if (CartCubit.get(context)
                                                    .inCartsRealTime[
                                                model.product!.id] ==
                                            true) {
                                          CartCubit.get(context)
                                              .changeCarts(model.product!.id);
                                        }
                                      },
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.delete_outline_outlined,
                                            color: Colors.black54,
                                          ),
                                          Text(
                                            'Remove',
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
