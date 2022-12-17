
 import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
 import 'package:flutter/material.dart';
 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shopapp/login/cubit/cubit.dart';
import 'package:shop_app/modules/shopapp/login/cubit/states.dart';
import 'package:shop_app/modules/shopapp/register/register.dart';
import 'package:shop_app/shared/component/components.dart';



 class shoplogin extends StatelessWidget
 {
   var emailshopcontroller=TextEditingController();
   var passshopcontroller=TextEditingController();
   var formkey=GlobalKey<FormState>();

   @override
   Widget build(BuildContext context) {
     return BlocProvider(

       create: (BuildContext context) {return logappcubit(); },

       child: BlocConsumer<logappcubit,logappstates>(
         listener: (context,state){
           if( state is loginsucessstate)
           {
                       //if(state.modellogin.status)
             //                          {
             //
             //                            print(state.modellogin.message);
             //                            toastmassage(massege: '${state.modellogin.message}', state: ToastState.Sucess);
             //                            cachehelper.savedata(key: 'token', value: state.modellogin.data!.token);
             //                            print(state.modellogin.data!.token);
             //                           navandreplace(context, shopapp());
             //
             //                          }else
             //                            {
             //                              print(state.modellogin.message);
             //                              toastmassage(massege: '${state.modellogin.message}', state: ToastState.Erorr);
             //                            }
                      }
         },
         builder: (context,state){
           return  Scaffold(
             appBar: AppBar(),
             body:Padding(
               padding: const EdgeInsets.all(40.0),
                 child: SingleChildScrollView(
                   child: Form(
                     key: formkey,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [


                                     Text(
                                       'Login',
                                       style:TextStyle(
                                         fontSize: 40,
                                         fontWeight: FontWeight.bold,                                    ),
                                     ),
                                     SizedBox(
                                       height: 15,
                                     ),
                                     Text(
                                       'Register now to browse our hot offers',
                                       style: TextStyle(
                                         fontSize: 25,
                                         fontWeight: FontWeight.bold,
                                         color: Colors.grey[400],
                                       ),
                                     ),
                                     SizedBox(
                                       height: 80,
                                     ),
                                     formfield(
                                       controller: emailshopcontroller,
                                       prefix: Icons.email,
                                       type: TextInputType.emailAddress,
                                       label: 'Email',
                                       validate: (String? value){
                                         if(value!.isEmpty)
                                         {
                                           return 'email adress must not be written' ;
                                         }
                                         else
                                         {
                                           return null;
                                         }
                                       },
                                     ),
                                     SizedBox(
                                       height:15 ,
                                     ),
                                     formfield(
                                       controller: passshopcontroller,
                                       prefix: Icons.password,
                                       type: TextInputType.visiblePassword,
                                       label: 'Password',
                                       isPassword: logappcubit.get(context).bolyian,
                                       validate: (String? value){
                                         if(value!.isEmpty)
                                         {
                                           return 'pass adress must not be written' ;
                                         }
                                         else
                                         {
                                           return null;
                                         }
                                       },
                                       suffix: logappcubit.get(context).suffix,
                                          onSuffixPressed: ()
                                         {
                                           logappcubit.get(context).changeiconpass();
                                         }

                                     ),
                                     SizedBox(
                                       height: 40,
                                     ),
                                     ConditionalBuilder(
                                       condition: state is!loginloadingstate,
                                       builder: (context)=>button(
                                         x: 50,
                                         width: 100,
                                         text: 'login',
                                         OnPressed: (){
                                           if(formkey.currentState!.validate()){
                                             logappcubit.get(context).userlogin
                                               (
                                               email: emailshopcontroller.text,
                                               password: passshopcontroller.text,
                                             );
                                           }

                                         },
                                       ),
                                       fallback:(context) =>Center(child: CircularProgressIndicator()),
                                     ),
                                     SizedBox(
                                       height: 20,
                                     ),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       children: [
                                         Text('Dont have an account?'),
                                         SizedBox(
                                           width: 5,
                                         ),
                                         TextButton(
                                           onPressed: (){
                                             navto(context, register());
                                           },
                                           child: Text(
                                             'REGISTER',
                                             style: TextStyle(
                                                 color: Colors.pink
                                             ),
                                           ),
                                         ),
                                       ],
                                     ),
                                   ],
                     ),
                   ),
                 ),

             ),
           );
         },

       ),
     );
   }

 }