import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/layout/shop_app/shop_app.dart';
import 'package:shop_app/modules/shopapp/favourite-screen.dart';
import 'package:shop_app/modules/shopapp/login/shoplogin.dart';
import 'package:shop_app/modules/shopapp/onboardingscreen.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';



void main()async {
  WidgetsFlutterBinding.ensureInitialized();


  DioHelper.init();
  await  cachehelper.init();
  bool isDark=cachehelper.Gettdata(key: "isdark");
  bool boarding=cachehelper.Gettdata(key: "boarding");
  String? token= cachehelper.Gettdata(key: 'token');
 // uId=cachehelper.Gettdata(key: 'uId');
  Widget startwidget;

if(boarding !=null)
  {
    if(token != null)

       startwidget=  shopapp();
      else

          startwidget=shoplogin();


  }else
    {
      startwidget=onboardingscreen();
    }

  runApp( MyApp(
    isDark,startwidget,
  ));
}
class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startwidget;

  MyApp(this.isDark,
      this.startwidget,);



  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [

        BlocProvider(
            create: (BuildContext context) =>
            shopcubit()
              ..homedatamodeluser()
              ..categoriesdatamodeluser()
                ..getFavData()
               ..profiledatamodeluser()
        ),

      ],
      child: BlocConsumer<shopcubit,shopappstate>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
           // themeMode:appcubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light,
          //  darkTheme: darkTheme,
            home: startwidget,
          );
        },
      ),

    );
  }

}
