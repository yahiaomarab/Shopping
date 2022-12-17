import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/userlogin.dart';
import 'package:shop_app/modules/shopapp/register/cubit/states.dart';
import 'package:shop_app/shared/constants/endpoints.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class registappcubit extends Cubit<registappstates>
{
    LoginModel?  signup;
  registappcubit():super(intialregisterstate());
  static registappcubit get(context)=>BlocProvider.of(context);
  void userregister(
       {
         required String email,
         required String password,
         required String username,
         required String phone,

       }
       )
   {
     emit(registerloadingstate());
     DioHelper.postdate(
       url: REGISTER,
       data:
       {
         'email':email,
         'password':password,
         'phone':phone,
         'name':username,
       }
       ,lang: 'ar',
     ).then((value) {
       print(value.data);
       signup=LoginModel .fromJson(value.data);
       print(signup!.data!.name);
       emit(registersucessstate(signup!));
     }).catchError((erorr){
       print(erorr.toString());
       emit(registererorrstate(erorr.toString()));
     });
   }
  bool bolyian=true;
  IconData suffix=Icons.visibility_off;
  void changeiconpass()
  {
    bolyian=!bolyian;
    suffix=bolyian? Icons.visibility_off :Icons.visibility;
    emit(registericonchangestate());
  }
}