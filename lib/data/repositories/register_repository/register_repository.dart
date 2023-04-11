import 'package:shop_app/api_constants.dart';
import 'package:shop_app/data/data_resource/api_service.dart';
import 'package:shop_app/data/models/user/user_model.dart';

class RegisterRepository {
  final ApiService apiService;
  RegisterRepository(this.apiService);

 Future<UserModel> getDataUserRegister({
    required String email,
    required String password,
    required String username,
    required String phone,
  }) async {
    final response =
        await apiService.postData(ApiConstants.REGISTER, body: {
      'email': email,
      'password': password,
      'phone': phone,
      'name': username,
    });
    return UserModel.fromJson(response.data);
  }
}
