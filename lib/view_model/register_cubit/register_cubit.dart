import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data/models/user/user_model.dart';
import 'package:shop_app/data/repositories/register_repository/register_repository.dart';
import 'package:shop_app/view_model/register_cubit/register_states.dart';
import '../../data/data_resource/api_service.dart';

class UserRegisterCubit extends Cubit<UserRegisterStates> {
  UserRegisterCubit() : super(IntialState());
  static UserRegisterCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  bool iconVisibility = true;
  IconData suffixIcon = Icons.visibility_off;
  final registerRepository = RegisterRepository(ApiService());

  void registerUser({
    required String email,
    required String password,
    required String username,
    required String phone,
  }) async {
    emit(RegisteringUserLoading());
    try {
     userModel=await registerRepository.getDataUserRegister(
          email: email, password: password, username: username, phone: phone)  ;

      emit(RegisteringUserSuccess(userModel!));
      print(userModel!.message);
    } catch (e) {
      emit(RegisteringUserErorr(e.toString()));
    }
  }

  void changeIconVisibility() {
    iconVisibility = !iconVisibility;
    suffixIcon = iconVisibility ? Icons.visibility_off : Icons.visibility;
    emit(ChangingIconState());
  }
}
