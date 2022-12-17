import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/models/favoritesmodel.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/styles/colors.dart';



class productscreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopcubit , shopappstate>(
      listener: (context , state){},
      builder: (context , state){
        return Container(
          color: Colors.grey[200],
          child: ConditionalBuilder(
            condition: state is! getfavoritesloadingstate,
            builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context , index) => buildListItem(shopcubit.get(context).favormodel!.data!.data![index].product, context),
                separatorBuilder: (context , index) => SizedBox(),
                itemCount: shopcubit.get(context).favormodel!.data!.data!.length
            ),
            fallback: (context) => Center(child: CircularProgressIndicator(color: defaultcolor,)) ,
          ),
        );
      },
    );
  }

}


