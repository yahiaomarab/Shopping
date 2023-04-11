import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/view_model/category_cubit/category_states.dart';
import '../../data/data_resource/api_service.dart';
import '../../data/models/categories/category_model.dart';
import '../../data/repositories/category_repository/category_repository.dart';

class CategoryCubit extends Cubit<CategoryStates>
{
  CategoryCubit():super(IntialState());
  static CategoryCubit get(context)=>BlocProvider.of(context);

  final CategoryRepository categoryRepository = CategoryRepository(ApiService());
  CategoryModel? categoryModel;

   getCategoriesData()async {
    emit(GettingCategoriesDataLoading());
    try {
      categoryModel = await categoryRepository.getCategoriesData();
      emit(GettingCategoriesDataSuccess());
      print(categoryModel!.data!.data.first.name);
    } catch (e) {
      emit(GettingCategoriesDataErorr(e.toString()));
    }
  }
}