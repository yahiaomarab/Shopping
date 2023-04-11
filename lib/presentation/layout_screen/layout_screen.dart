import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/presentation/search_screen/search_screen.dart';
import 'package:shop_app/presentation/settings_screen/settings_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../view_model/user_cubit/user_cubit.dart';
import '../../view_model/user_cubit/user_states.dart';
import '../../widgets/component/components.dart';

class LayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..getUserProfileData(context),
      child: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = UserCubit.get(context);
          return Scaffold(
            drawer: Drawer(
              child: ListView(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text('${cubit.userData?.data!.name}'),
                    accountEmail: Text('${cubit.userData?.data!.email}'),
                    currentAccountPicture: CircleAvatar(
                      child: ClipOval(
                        child: Image.network(
                          '${cubit.userData?.data!.image}',
                          fit: BoxFit.cover,
                          width: 90,
                          height: 90,
                        ),
                      ),
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              'https://www.bing.com/th?id=OIP.a20Rx0lnOyPXgCS3MjbpJgHaEK&w=333&h=187&c=8&rs=1&qlt=90&o=6&dpr=1.75&pid=3.1&rm=2')),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () => navTo(context, SettingsScreen()),
                  ),
                  ListTile(
                    leading: const Icon(Icons.description),
                    title: const Text('Policies'),
                    onTap: () => null,
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text('Exit'),
                    leading: const Icon(Icons.exit_to_app),
                    onTap: () {
                      cubit.signOut(context);
                    },
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              title: const Text(
                'SHOPPING',
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    navTo(context, SearchScreen());
                  },
                  icon: const Icon(
                    Icons.search,
                  ),
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Container(
                height: 70,
                child: GNav(
                  rippleColor: Colors.white,
                  // tab button ripple color when pressed
                  hoverColor: Colors.white,
                  // tab button hover color
                  haptic: true,
                  // haptic feedback
                  tabBorderRadius: 15,

                  curve: Curves.easeOutExpo,
                  // tab animation curves
                  duration: const Duration(milliseconds: 200),
                  gap: 8,
                  color: Colors.black,
                  activeColor: HexColor('3333FF'),
                  iconSize: 24,
                  tabBackgroundColor: HexColor('3333FF').withOpacity(0.1),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  // navigation bar padding
                  tabs: const [
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
                  onTabChange: (int index) {
                    cubit.changeBottomNavIndex(index, context);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
