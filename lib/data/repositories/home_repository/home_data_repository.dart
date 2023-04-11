import 'package:shop_app/api_constants.dart';
import 'package:shop_app/data/data_resource/api_service.dart';
import 'package:shop_app/data/models/home/home_model.dart';

import '../../data_resource/shared_prefrence.dart';

class HomeRepository {
  final ApiService apiService;
  HomeRepository(this.apiService);

  Future<HomeModel> getHomeData() async {
    final response = await apiService.getData(
      ApiConstants.HOME,
      token:await AdvancedSharedPreferences.getString('token'),
    );
    return HomeModel.fromJson(response.data);
  }

  Future<ProductModel> getHomeProductData() async {
    final response = await apiService.getData(
      ApiConstants.HOME,
      token:await AdvancedSharedPreferences.getString('token'),
    );
    return ProductModel.fromJson(response.data);
  }
}
