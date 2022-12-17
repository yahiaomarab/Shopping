import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/models/favoritesmodel.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class favourite_screen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopcubit,shopappstate>(
      listener: (context,state){},
      builder:(context,state)=>Scaffold(
        appBar: AppBar(),
        body: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context,index)=>fav_item(shopcubit.get(context).favormodel!.data!.data![index]),
          separatorBuilder:(context,index)=>dividorline(),
          itemCount: shopcubit.get(context).favormodel!.data!.data!.length,
        ),
      ),
    );
  }
  Widget fav_item(FavData model)
  {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage('${model.product!.image}'),
            height: 100,
            width: 100,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            '${model.product!.name}',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.star,color:defaultcolor),
          ),
        ],
      ),
    );
  }
}