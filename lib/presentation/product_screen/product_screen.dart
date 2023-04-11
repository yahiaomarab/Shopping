import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/presentation/home_screen/homescreen.dart';
import 'package:shop_app/view_model/home_cubit/home_cubit.dart';
import 'package:shop_app/view_model/home_cubit/home_states.dart';

import '../../data/models/home/home_model.dart';
import '../../widgets/component/components.dart';

class ProductScreen extends StatelessWidget {
  ProductModel? model;
  ProductScreen({required this.model});
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      HomeCubit.get(context).getHomeData(context);
      return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) => GestureDetector(
          onTap: () {
            navTo(context, HomeScreen());
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 70,
                  left: 15,
                  right: 15,
                  bottom: 20,
                ),
                child: Column(
                  children: [
                    Hero(
                      tag: model?.id,
                      child: Image(
                        image: NetworkImage(model?.image),
                        width: double.infinity,
                        height: 400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
