import 'package:shop_app/data/data_resource/api_service.dart';

import '../../../api_constants.dart';
import '../../models/categories/category_model.dart';

class CategoryRepository{
  final ApiService apiService;
  CategoryRepository(this.apiService);
 Future<CategoryModel> getCategoriesData()async {
    final response = await apiService.getData(
      ApiConstants.CATEGORIES,
    );
    return CategoryModel.fromJson(response.data);
  }
}