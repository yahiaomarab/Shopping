import '../../../api_constants.dart';
import '../../data_resource/api_service.dart';
import '../../models/categories/cat_model.dart';

class CatRepo
{
  final ApiService apiService;
  CatRepo(this.apiService);
  Future<CategoryProducts> getCategoriesData(id)async {
    final response = await apiService.getData(
      '${ApiConstants.CATEGORIES}/$id',
    );
    return CategoryProducts.fromJson(response.data);
  }
}
