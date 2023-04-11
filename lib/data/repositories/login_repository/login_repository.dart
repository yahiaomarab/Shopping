import 'package:shop_app/api_constants.dart';

import '../../data_resource/api_service.dart';
import '../../models/user/user_model.dart';

class LoginRepository {
  final ApiService apiService;
  LoginRepository(this.apiService);

 Future<UserModel> getDataUserLogin({
    required String email,
    required String password,
  }) async {
    final response = await apiService.postData(
      ApiConstants.LOGIN,
      body: {
        'email': email,
        'password': password,
      },
    );
    return UserModel.fromJson(response.data);
  }
}
