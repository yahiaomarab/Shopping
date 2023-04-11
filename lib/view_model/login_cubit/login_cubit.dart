import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data/data_resource/api_service.dart';
import 'package:shop_app/data/repositories/login_repository/login_repository.dart';
import '../../data/models/user/user_model.dart';
import 'login_states.dart';

class UserLoginCubit extends Cubit<UserLoginStates> {
  UserLoginCubit() : super(IntialState());
  static UserLoginCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  final LoginRepository loginRepository = LoginRepository(ApiService());
  bool iconVisibility = true;
  IconData suffixIcon = Icons.visibility_off;

  void loginUser({
    required String email,
    required String password,
  })async {
    emit(LoginingUserLoading());
    try {
    userModel=await  loginRepository.getDataUserLogin(email: email, password: password);
      emit(LoginingUserSuccess(userModel!));
    } catch (e) {
      emit(LoginingUserErorr(e.toString()));
    }
  }

  void changeIconVisibility() {
    iconVisibility = !iconVisibility;
    suffixIcon = iconVisibility ? Icons.visibility_off : Icons.visibility;
    emit(ChangingIconState());
  }
}
