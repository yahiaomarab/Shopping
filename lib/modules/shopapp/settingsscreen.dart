import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';


class settingsscreen extends StatelessWidget
{
  var updatekey=GlobalKey<FormState>();
  var namecontroller=TextEditingController();
  var emailcontroller=TextEditingController();
  var phonecontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
       BlocConsumer<shopcubit,shopappstate>(
         listener: (context,state){},
         builder: (context,state) {
           var model=shopcubit.get(context).profilemodel;
            namecontroller.text=model?.data?.name;
            emailcontroller.text=model?.data?.email;
            phonecontroller.text=model?.data?.phone;
        return   ConditionalBuilder(
             condition: true,
             builder: (context) =>
                 Padding(
                   padding: const EdgeInsets.all(30),
                   child: SingleChildScrollView(
                     physics: BouncingScrollPhysics(),
                     child: Form(
                       key: updatekey,
                       child: Column(
                         children: [
                           formfield(
                             controller: namecontroller,
                             prefix: Icons.person,
                             type: TextInputType.text,
                             label: 'User Name',
                             validate: (String? value) {
                               if (value!.isEmpty) {
                                 return 'user name must not be written';
                               }
                               else {
                                 return null;
                               }
                             },
                           ),
                           SizedBox(
                             height: 35,
                           ),
                           formfield(
                             controller: emailcontroller,
                             prefix: Icons.email_outlined,
                             type: TextInputType.emailAddress,
                             label: 'Email',
                             validate: (String? value) {
                               if (value!.isEmpty) {
                                 return 'email adress must not be written';
                               }
                               else {
                                 return null;
                               }
                             },
                           ),
                           SizedBox(
                             height: 35,
                           ),


                           formfield(
                             controller: phonecontroller,
                             prefix: Icons.phone,
                             type: TextInputType.phone,
                             label: 'Phone Number',
                             validate: (String? value) {
                               if (value!.isEmpty) {
                                 return 'phone number must not be written';
                               }
                               else {
                                 return null;
                               }
                             },
                           ),
                           SizedBox(
                             height: 50,
                           ),
                           button(
                             x: 40,
                             text: 'UPDATE', OnPressed: () {
                            shopcubit.get(context).updatemodeluser(
                                name: namecontroller.text,
                                phone: phonecontroller.text,
                                email: emailcontroller.text,
                            );
                           }, width: double.infinity,
                           ),
                           SizedBox(
                             height: 15,
                           ),
                           button(
                             x: 40,
                             text: 'LOGOUT', OnPressed: () {
                               signout(context);
                           }, width: double.infinity,
                           ),
                         ],
                       ),
                     ),
                   ),
                 ),
             fallback: (context) => Center(child: CircularProgressIndicator()),

           );
         },
       );
  }

}