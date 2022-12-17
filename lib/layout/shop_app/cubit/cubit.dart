
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/modules/shopapp/favourite-screen.dart';
import 'package:shop_app/modules/shopapp/productscreen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import '../../../models/categoriesmodel.dart';
import '../../../models/change_favorites.dart';
import '../../../models/favoritesmodel.dart';
import '../../../models/searchmodel.dart';

import '../../../models/homemodel.dart';
import '../../../models/userlogin.dart';
import '../../../modules/shopapp/categoreisscreen.dart';
import '../../../modules/shopapp/homescreen.dart';
import '../../../modules/shopapp/settingsscreen.dart';
import '../../../shared/constants/constants.dart';
import '../../../shared/constants/endpoints.dart';
import '../../../shared/network/remote/dio_helper.dart';


class shopcubit extends Cubit<shopappstate>
{
  shopcubit():super(shopintialstate());
  static shopcubit get(context)=>BlocProvider.of(context);
  int currentindex=0;
  HomeModel? homeee;
  CategoriesModel? catmodel;
  FavouriteModel? favormodel;
  changefavoritesmodel? changefavmodel;
  LoginModel? profilemodel;
  SearchModel? searchModel;
  List<Widget>screenss=[
    homescreen(),
    categoreisscreen(),
    productscreen(),
    settingsscreen(),
  ];
  Map<int,bool>favorites={};
  void changebottomindex(int index)
  {
    currentindex=index;
    emit(shopbottomnavstate());
  }


  void homedatamodeluser()
  {
    token = cachehelper.Gettdata(key: 'token');
    print(token);
    emit(homeloadingstate());
    DioHelper.getdata(
        url: HOME,
      token: token,
    ).then((value)  {
      homeee= HomeModel.fromJson(value.data);
     homeee!.data!.products.forEach((element)
      {
        favorites.addAll({
          element.id! : element.inFavorites!
        });
      });
      print(favorites.toString());
      emit(homesucessstate());
    }).catchError((erorr){

      print(erorr.toString());
      emit(homeerorrstate(erorr.toString()));
    });

  }

  void changeFav(int productId){
    if(favorites[productId] == true )
    {
      favorites[productId] = false;
    } else {
      favorites[productId] = true;
    }
    emit(favoritechangessucessstate());



    DioHelper.postdate(
        url: FAVORITES,
        data: {
          'product_id' : productId
        },
        token: token
    ).then((value) {
      changefavmodel = changefavoritesmodel.formjson(value.data);
      print(value.data);
      if(changefavmodel!.status == false ){
        if(favorites[productId] == true )
        {
          favorites[productId] = false;
        } else {
          favorites[productId] = true;
        }
      }else {
        getFavData();
      }
      emit(favoritechangessucessstate());

    }).catchError((error){
      if(favorites[productId] == true )
      {
        favorites[productId] = false;
      } else {
        favorites[productId] = true;
      }
      emit(favoriteserorrstate(error.toString()));
    });
  }


  void getFavData(){
    DioHelper.getdata(
        url: FAVORITES,
        token: token
    ).then((value) {
      favormodel = FavouriteModel.fromJson(value.data);
      print(value.data.toString());
      emit(getfavoritessucessstate());
    }).catchError((error){
      emit(getfavoriteserorrstate(error.toString()));
    });
  }


  void categoriesdatamodeluser()
  {
    DioHelper.getdata(
      url: CATEGORIES,
    ).then((value)  {
     // print(value.data);
      catmodel= CategoriesModel.fromJson(value.data);
      emit(categoriessucessstate());
    }).catchError((erorr){
      print(erorr.toString());
      emit(categorieserorrstate(erorr.toString()));
    });

  }

  void profiledatamodeluser()
   {
     DioHelper.getdata(
       url: PROFILE,
       token: token,
     ).then((value)  {
       emit(profileloadingstate());
       profilemodel= LoginModel.fromJson(value.data);
       print(profilemodel!.data!.name);
       emit(profilesucessstate(profilemodel!));
     }).catchError((erorr){
       print(erorr.toString());
       emit(profileerorrstate(erorr.toString()));
     });

   }
   void updatemodeluser(
  {
  required String name,
    required String phone,
    required String email,
}
       )
   {
     DioHelper.postdate(
         url: UPDATE_PROFILE,
         data: {
           'name':name,
           'email':email,
           'phone':phone,
         }

     ).then((value) {
       profilemodel=LoginModel.fromJson(value.data);
       emit(updateprofilesuccessstate());
     }).catchError((erorr){
       emit(updateprofileerorrstate(erorr.toString()));
     });

   }
   void searchfor({
  required String text,
})
   {
     DioHelper.postdate(
         url: SEARCH,
         data: {
           'text':text,
         },
     ).then((value) {
    searchModel=SearchModel.fromJson(value.data);
    emit(searchsuccessstate());
     }).catchError((erorr)
     {
    emit(searcherorrstate(erorr.toString()));
     });
   }
}