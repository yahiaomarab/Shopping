import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/models/categoriesmodel.dart';
import 'package:shop_app/shared/component/components.dart';

class categoreisscreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopcubit,shopappstate>(
      listener: (context,state){},
     builder:(context,state)=>Scaffold(
        appBar: AppBar(),
        body: ListView.separated(
          physics: BouncingScrollPhysics(),
            itemBuilder: (context,index)=>catitem(shopcubit.get(context).catmodel!.data!.data[index]),
            separatorBuilder:(context,index)=>dividorline(),
            itemCount: shopcubit.get(context).catmodel!.data!.data.length,
        ),
      ),
    );
  }
Widget catitem(DataModel model)
{
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage('${model.image}'),
          height: 100,
          width: 100,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          '${model.name}',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        Spacer(),
        IconButton(
          onPressed: (){},
          icon: Icon(Icons.arrow_forward_ios),
        ),
      ],
    ),
  );
}
}