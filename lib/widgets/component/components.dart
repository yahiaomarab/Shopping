import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_app/presentation/product_screen/product_screen.dart';
import 'package:shop_app/view_model/favourite_cubit/favourite_cubit.dart';
import 'package:shop_app/widgets/styles/colors/colors.dart';
import '../../data/models/categories/category_model.dart';
import '../../data/models/home/home_model.dart';
import '../../view_model/product_cubit/product_cubit.dart';

Future<void> navTo(context, widget) async {
  Navigator.push(
    context,
    PageTransition(
        type: PageTransitionType.fade,
        child: widget,
        duration: const Duration(milliseconds: 700)),
  );
}

void navAndReplace(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (Route<dynamic> route) => false,
  );
}

Future<bool?> toastMessage({
  required String message,
  required ToastState state,
}) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: choseColorToast(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastState { error, success, warning }

Color choseColorToast(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.success:
      color = Colors.green;
      break;
    case ToastState.error:
      color = Colors.red;
      break;
    case ToastState.warning:
      color = Colors.blue;
      break;
  }
  return color;
}

PreferredSizeWidget buildAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios_new_outlined),
      ),
      title: Text(title!),
      actions: actions,
    );

Widget textFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  VoidCallback? onTap,
  Function(String)? onChanged,
  required String? Function(String?)? validate,
  required String label,
  IconData? prefix,
  IconData? suffix,
  bool isPassword = false,
  bool isClickable = true,
  VoidCallback? onSuffixPressed,
}) =>
    TextFormField(
      validator: validate,
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(
            prefix,
          ),
          suffixIcon: GestureDetector(
            child: Icon(suffix),
            onTap: onSuffixPressed,
          ),
          border: const OutlineInputBorder()),
      keyboardType: type,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      onTap: onTap,
    );

Widget button({
  required double x,
  required String text,
  required onPressed,
  required double width,
}) {
  return Container(
    color: Colors.grey[400],
    width: width,
    height: x,
    child: MaterialButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  );
}

Widget devidorLine() {
  return Padding(
    padding: const EdgeInsetsDirectional.only(
      start: 20,
      top: 20,
      bottom: 10,
    ),
    child: Container(
      height: 1,
      width: double.infinity,
      color: Colors.grey[300],
    ),
  );
}

Widget buildSearchItem(list, context) {
  return InkWell(
    onTap: () {},
    child: Row(
      children: [
        InkWell(
          onTap: () {},
          child: Row(
            children: [
              CircleAvatar(
                radius: 27,
                backgroundImage: NetworkImage('${list.image}'),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${list.name}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget buildProductItem(model, context, {bool isOldPrice = true}) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: GestureDetector(
        onTap: () {
          navTo(context, ProductScreen(model.id));
          ProductCubit.get(context).getProductData(model.id);

        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: Colors.white,
            height: 120,
            child: Row(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  child: Stack(
                    children: [
                      Hero(
                        tag: model.id,
                        child: Image(
                          image: NetworkImage(model.image),
                        ),
                      ),
                      Row(
                        children: [
                          if (model.discount != 0 && isOldPrice)
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              color: Colors.red[300],
                              child: const Text(
                                'OFFER !',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                FavouriteCubit.get(context)
                                    .changeProductFavourite(model.id);
                              },
                              icon: Icon(
                                FavouriteCubit.get(context)
                                        .FavoritesProducts[model.id]!
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: FavouriteCubit.get(context)
                                        .FavoritesProducts[model.id]!
                                    ? Colors.red
                                    : Colors.grey,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          model.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            if (model.discount != 0 && isOldPrice)
                              Text(
                                '\$ ${model.oldPrice}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough),
                              ),
                            if (model.discount == 0 && isOldPrice)
                              const Text(
                                '',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough),
                              )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Price',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[600]),
                            ),
                            const Spacer(),
                            Text(
                              '\$ ${model.price}',
                              style: const TextStyle(
                                  fontSize: 16, color: defaultColor),
                            )
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
Widget buildGridProduct(ProductModel model, context) {
  return GestureDetector(
    onTap: () {
      navTo(context, ProductScreen(
            model.id,
          ));
      ProductCubit.get(context).getProductData(model.id);

    },
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Stack(
                children: [
                  Image(
                    image: NetworkImage(model.image),
                    width: double.infinity,
                    height: 200,
                  ),
                  Row(
                    children: [
                      if (model.discount != 0)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          color: Colors.red[300],
                          child: const Text(
                            'OFFER !',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            FavouriteCubit.get(context)
                                .changeProductFavourite(model.id);
                            print(model.id);
                          },
                          icon: Icon(
                            FavouriteCubit.get(context)
                                    .FavoritesProducts[model.id]!
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: FavouriteCubit.get(context)
                                    .FavoritesProducts[model.id]!
                                ? defaultColor
                                : Colors.grey,
                          ))
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      model.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        if (model.discount != 0)
                          Text(
                            '\$ ${model.oldPrice}',
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                        if (model.discount == 0)
                          const Text(
                            '',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Price',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                        const Spacer(),
                        Text(
                          '\$ ${model.price}',
                          style: const TextStyle(
                              fontSize: 16, color: defaultColor),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildCategoryItem(
  DataModel model,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      FittedBox(
        fit: BoxFit.fill,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.black.withOpacity(0.8),
              width: 100,
              child: Text(
                '${model.name}',
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
Widget defaultButton(
    {
      double? height,
      IconData? icon,
      double width = double.infinity,
      double radius = 30.0,
      Color background = customColor,
      required Function function,
      required String text,
    }) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: background,
          boxShadow: [BoxShadow(
            color: Colors.grey.withOpacity(0.5),spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),

          ),]
      ),
      child: MaterialButton(onPressed: () {
        function();
      },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(icon,color: Colors.white,),
              ),
            Text(
              text,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
              ),
            ),
          ],
        ),
      ),
    );
