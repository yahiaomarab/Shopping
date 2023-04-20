import 'package:shop_app/data/data_resource/api_service.dart';
import '../../../api_constants.dart';
import '../../data_resource/shared_prefrence.dart';
import '../../models/product/product_model.dart';

class ProductRepository {
  final ApiService apiService;
  ProductRepository(this.apiService);

  Future<ProductDetails> getProductData(int? id) async {
    final response = await apiService.getData('${ApiConstants.PRODUCT}/$id',
        token: await AdvancedSharedPreferences.getString('token'));
    return ProductDetails.fromJson(response.data);
  }
}
