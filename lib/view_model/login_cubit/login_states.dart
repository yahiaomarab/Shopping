import 'package:shop_app/data/models/user/user_model.dart';

abstract class UserLoginStates {}

class IntialState extends UserLoginStates {}

class LoginingUserLoading extends UserLoginStates {}

class LoginingUserSuccess extends UserLoginStates {
  final UserModel userModel;
  LoginingUserSuccess(this.userModel);
}

class LoginingUserErorr extends UserLoginStates {
  final String erorr;

  LoginingUserErorr(this.erorr);
}

class ChangingIconState extends UserLoginStates {}
