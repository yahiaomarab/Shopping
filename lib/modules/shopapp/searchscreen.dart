import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class searchscreen extends StatelessWidget
{
  var searchcontroller=TextEditingController();
  var formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopcubit,shopappstate>(
      listener: (context,state){},
      builder: (context,state)=>Scaffold(
        appBar: AppBar(),
        body:
        Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                formfield(controller: searchcontroller, type: TextInputType.text,
                  validate: (String?value){
                    if(value!.isEmpty)
                    {
                      return 'Write What You Want!!';
                    }
                    return null;
                  },
                  prefix: Icons.search,
                  label:'search',
                  onChanged: (String value)
                  {
                   shopcubit.get(context).searchfor(text: value);
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                if(state is searchloadingstate)
                  Center(child: CircularProgressIndicator(color: defaultcolor,),)
                else if(state is searchsuccessstate)
                  Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                        itemBuilder: (context,index)=>buildListItem(shopcubit.get(context).searchModel!.data!.data![index], context,isOldPrice: false),
                        separatorBuilder: (context,state)=>SizedBox(height: 10,),
                        itemCount: shopcubit.get(context).searchModel!.data!.data!.length,
                    ),
                  ),
              ],
            ),

          ),
        ),
      ),
    );
  }

}