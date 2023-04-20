import 'package:shop_app/api_constants.dart';
import 'package:shop_app/data/data_resource/shared_prefrence.dart';

import '../../data_resource/api_service.dart';
import '../../models/carts/cart_model.dart';

class CartRepository {
  final ApiService apiService;
  CartRepository(this.apiService);
  changeCarts(id) async {
    final response = await apiService.postData(ApiConstants.CARTS,
        body: {'product_id': id},
        token: await AdvancedSharedPreferences.getString('token'));
    return InCartsModel.fromJson(response.data);
  }

  updateCarts(id, quantiy) async {
    await apiService.update(
        '${ApiConstants.CARTS}/$id',
        body: {'quantity': quantiy},
        token: await AdvancedSharedPreferences.getString('token'));
  }

  Future<InCartsModel> getCarts() async {
    final response = await apiService.getData(
      ApiConstants.CARTS,
      token: await AdvancedSharedPreferences.getString('token'),
    );
    return InCartsModel.fromJson(response.data);
  }
}
