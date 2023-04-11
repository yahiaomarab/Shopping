import 'package:shop_app/api_constants.dart';
import 'package:shop_app/data/data_resource/api_service.dart';
import 'package:shop_app/data/models/favourite/change_favourite_model.dart';

import '../../data_resource/shared_prefrence.dart';
import '../../models/favourite/favourite_model.dart';

class FavouriteRepository {
  final ApiService apiService;
  FavouriteRepository(this.apiService);

  Future<FavouriteModel> getFavouriteData() async {
    final response = await apiService.getData(ApiConstants.FAVORITES,
        token: await AdvancedSharedPreferences.getString('token'));
    return FavouriteModel.fromJson(response.data);
  }

  changeFavouriteData(int ProductId) async {
    final response = await apiService.postData(ApiConstants.FAVORITES,
        body: {'product_id': ProductId}, token:await AdvancedSharedPreferences.getString('token'));
    return ChangingProductFavouriteModel.formjson(response.data);
  }
}
