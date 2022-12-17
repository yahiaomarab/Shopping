import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/modules/shopapp/searchscreen.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class shopapp extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
  
    return
      BlocConsumer<shopcubit,shopappstate>(

        listener: (context,state){},
        builder: (context,state)=>Scaffold(
          appBar: AppBar(
            title: Text(
              'SHOPPING',
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: ()
                {
                  navto(context, searchscreen());
                },
                icon: Icon(Icons.search,),
              ),
            ],
          ),
          body: shopcubit.get(context).screenss[shopcubit.get(context).currentindex],

          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
            ),
            child: Container(
            height: 70,
            child: GNav(

              rippleColor: Colors.white, // tab button ripple color when pressed
              hoverColor: Colors.white, // tab button hover color
              haptic: true, // haptic feedback
              tabBorderRadius: 15,

              curve: Curves.easeOutExpo, // tab animation curves
              duration: Duration(milliseconds: 200),
              gap: 8,
              color: Colors.black,
              activeColor: HexColor('3333FF'),
              iconSize: 24,
              tabBackgroundColor: HexColor('3333FF').withOpacity(0.1),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5), // navigation bar padding
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.apps,
                  text: 'Categories',
                ),
                GButton(
                  icon: Icons.favorite,
                  text: 'Favorites',
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'Settings',
                ),
              ],
              onTabChange: (int index){
                shopcubit.get(context).changebottomindex(index);
              },

            ),
        ),
          ),


        ),

      );
  }

}