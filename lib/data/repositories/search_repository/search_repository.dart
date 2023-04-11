import 'package:shop_app/api_constants.dart';
import 'package:shop_app/data/data_resource/api_service.dart';

import '../../models/search/search_model.dart';

class SearchRepository {
  final ApiService apiService;
  SearchRepository(this.apiService);

  Future<SearchModel> searchProduct({
    required String text,
  }) async {
    final response = await apiService.postData(
      ApiConstants.SEARCH,
      body: {
        'text': text,
      },
    );
    return SearchModel.fromJson(response.data);
  }
}
