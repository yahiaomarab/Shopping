import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/view_model/search_cubit/search_states.dart';
import '../../data/data_resource/api_service.dart';
import '../../data/models/search/search_model.dart';
import '../../data/repositories/search_repository/search_repository.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(IntialState());
  static SearchCubit get(context) => BlocProvider.of(context);

  final SearchRepository searchRepository = SearchRepository(ApiService());
  SearchModel? searchModel;

  Future<void> searchData({
    required String text,
  }) async {
    emit(SearchingDataLoading());
    try {
      searchModel = await searchRepository.searchProduct(text: text);
      emit(SearchingDataSuccess());
    } catch (erorr) {
      emit(SearchingDataErorr(erorr.toString()));
    }
  }
}
