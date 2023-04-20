import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/view_model/product_cubit/product_states.dart';
import '../../data/data_resource/api_service.dart';
import '../../data/models/product/product_model.dart';
import '../../data/repositories/product_repository/product_repository.dart';

class ProductCubit extends Cubit<ProductStates> {
  ProductCubit() : super(IntialState());
  static ProductCubit get(context) => BlocProvider.of(context);

  final productRepository = ProductRepository(ApiService());
  ProductDetails? productDetails;

  void getProductData(id) async {
    emit(GettingProductDataLoading());
    try {
      productDetails = await productRepository.getProductData(id);
      emit(GettingProductDataSuccess());
      print(productDetails!.data!);
    } catch (error) {
      emit(GettingProductDataError(error.toString()));
    }
  }
}
