import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/userlogin.dart';
import 'package:shop_app/modules/shopapp/login/cubit/states.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/constants/endpoints.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';


class logappcubit extends Cubit<logappstates>
{
  LoginModel?  modellogin;
  logappcubit():super(intialloginstate());
  static logappcubit get(context)=>BlocProvider.of(context);
  void userlogin(
  {
  required String email,
    required String password,
}
      )
  {
    emit(loginloadingstate());
    DioHelper.postdate(
        url: Login,
        data:
        {
       'email':email,
       'password':password,
        },
        lang: 'ar',
    ).then((value) {
      print(value.data);
   modellogin=LoginModel .fromJson(value.data);
   print(modellogin!.data!.name);
      emit(loginsucessstate());
    }).catchError((erorr){
      print(erorr.toString());
      emit(loginerorrstate(erorr.toString()));
    });
  }
  bool bolyian=true;
  IconData suffix=Icons.visibility_off;
  void changeiconpass()
  {
    bolyian=!bolyian;
    suffix=bolyian? Icons.visibility_off :Icons.visibility;
    emit(loginiconchangestate());
  }
}