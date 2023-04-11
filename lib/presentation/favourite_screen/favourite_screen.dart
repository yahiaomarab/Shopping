import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/view_model/favourite_cubit/favourite_cubit.dart';
import 'package:shop_app/view_model/favourite_cubit/favourite_states.dart';
import '../../widgets/component/components.dart';
import '../../widgets/styles/colors/colors.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouriteCubit, FavouriteStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = FavouriteCubit.get(context);
        return Container(
          color: Colors.grey[200],
          child: ConditionalBuilder(
            condition: state is! GettingFavouriteProductDataLoading,
            builder: (context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildProductItem(
                    cubit.favouriteModel!.data!.data![index].product, context),
                separatorBuilder: (context, index) => const SizedBox(),
                itemCount: cubit.favouriteModel!.data!.data!.length),
            fallback: (context) => const Center(
                child: CircularProgressIndicator(
              color: defaultColor,
            )),
          ),
        );
      },
    );
  }
}
