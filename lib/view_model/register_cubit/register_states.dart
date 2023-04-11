import 'package:shop_app/data/models/user/user_model.dart';

abstract class UserRegisterStates {}

class IntialState extends UserRegisterStates {}

class RegisteringUserLoading extends UserRegisterStates {}

class RegisteringUserSuccess extends UserRegisterStates {
  final UserModel userModel;
  RegisteringUserSuccess(this.userModel);
}

class RegisteringUserErorr extends UserRegisterStates {
  final String erorr;
  RegisteringUserErorr(this.erorr);
}

class ChangingIconState extends UserRegisterStates {}
