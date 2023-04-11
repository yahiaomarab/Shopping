import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data/data_resource/shared_prefrence.dart';
import 'package:shop_app/presentation/layout_screen/layout_screen.dart';
import 'package:shop_app/presentation/login_screen/login_screen.dart';
import 'package:shop_app/presentation/onBoarding_screen/onboardingscreen.dart';
import 'package:shop_app/view_model/category_cubit/category_cubit.dart';
import 'package:shop_app/view_model/favourite_cubit/favourite_cubit.dart';
import 'package:shop_app/view_model/home_cubit/home_cubit.dart';
import 'package:shop_app/view_model/user_cubit/user_cubit.dart';
import 'package:shop_app/widgets/styles/themes/light_theme/light_Theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AdvancedSharedPreferences.init();
  final boarding = AdvancedSharedPreferences.getBool("boarding");
  final token = AdvancedSharedPreferences.getString('token');
  Widget startwidget;

  if (boarding != null) {
    if (token != null)
      startwidget = LayoutScreen();
    else
      startwidget = LoginScreen();
  } else {
    startwidget = onboardingscreen();
  }

  runApp(MyApp(
    startwidget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startwidget;

  MyApp(
    this.startwidget,
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeCubit()..getHomeData(context)),
          BlocProvider(
              create: (context) => CategoryCubit()..getCategoriesData()),
          BlocProvider(
              create: (context) => FavouriteCubit()..getFavouriteProductData()),
          BlocProvider(
              create: (context) => UserCubit()..getUserProfileData(context)),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          home: startwidget,
        ));
  }
}
