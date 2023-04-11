import 'package:shop_app/api_constants.dart';
import 'package:shop_app/data/data_resource/api_service.dart';
import 'package:shop_app/data/models/user/user_model.dart';

import '../../data_resource/shared_prefrence.dart';

class UserRepository {
  final ApiService apiService;
  UserRepository(this.apiService);


  Future<UserModel> getUserProfileData() async {
    final response = await apiService.getData(
      ApiConstants.PROFILE,
      token:await AdvancedSharedPreferences.getString('token'),
    );
    return UserModel.fromJson(response.data);
  }

  Future<UserModel> updateUserData({
    required String name,
    required String phone,
    required String email,
  }) async {
    final response =
        await apiService.update(ApiConstants.UPDATE_PROFILE, body: {
      'name': name,
      'email': email,
      'phone': phone,
    });
    return UserModel.fromJson(response.data);
  }
}
