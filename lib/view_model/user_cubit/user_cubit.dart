import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data/data_resource/shared_prefrence.dart';
import 'package:shop_app/view_model/home_cubit/home_cubit.dart';
import 'package:shop_app/view_model/user_cubit/user_states.dart';
import '../../data/data_resource/api_service.dart';
import '../../data/models/user/user_model.dart';
import '../../data/repositories/user_repository/user_data_repository.dart';
import '../../presentation/category_screen/category_screen.dart';
import '../../presentation/favourite_screen/favourite_screen.dart';
import '../../presentation/home_screen/homescreen.dart';
import '../../presentation/login_screen/login_screen.dart';
import '../../presentation/settings_screen/settings_screen.dart';
import '../../widgets/component/components.dart';

class UserCubit extends Cubit<UserStates>
{
  UserCubit():super(IntialState());
  static UserCubit get(context)=>BlocProvider.of(context);
  final UserRepository userRepository = UserRepository(ApiService());
  UserModel? userData;
  var NameController = TextEditingController();
  var EmailController = TextEditingController();
  var PhoneController = TextEditingController();

  void getUserProfileData(context) async {
    emit(GettingProfileDataLoading());
    try {
      userData = await userRepository.getUserProfileData();
      emit(GettingProfileDataSuccess());
      HomeCubit.get(context).getHomeData(context);
      print(userData!.data!.token);
    } catch (e) {
      emit(GettingProfileDataErorr(e.toString()));
    }
  }

  void updateUserProfileData() async {
    emit(UpdatingProfileDataLoading());
    try {
      userData = await userRepository.updateUserData(
          name: NameController.text,
          phone: PhoneController.text,
          email: EmailController.text);
      emit(UpdatingProfileDataSuccess());
    } catch (e) {
      emit(UpdatingProfileDataErorr(e.toString()));
    }
  }
  void signOut(context)
  {
    AdvancedSharedPreferences.remove('token');
    navAndReplace(context, LoginScreen());
  }

  int currentIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    CategoryScreen(),
    FavouriteScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavIndex(int index,context) {
    currentIndex = index;
    emit(ChangingBottomIndexState());
  }
}