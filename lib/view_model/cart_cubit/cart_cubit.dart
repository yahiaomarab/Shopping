import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data/models/carts/cart_model.dart';
import 'package:shop_app/data/repositories/cart_repository/cart_repository.dart';
import 'package:shop_app/view_model/cart_cubit/cart_states.dart';
import '../../data/data_resource/api_service.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(InitialState());
  static CartCubit get(context) => BlocProvider.of(context);

  Map<int, bool> inCartsRealTime = {};
  final CartRepository cartRepository = CartRepository(ApiService());
  InCartsModel? cartsModel;

  void changeCarts(id) async {
    emit(ChangingCartLoadingState());
    checkProductCart(id);
    try {
      cartsModel = await cartRepository.changeCarts(id);
      emit(ChangingCartSuccessState(cartsModel));
      if (cartsModel!.status == false) {
        checkProductCart(id);
      } else {
        getCarts();
      }
    } catch (error) {
      emit(ChangingCartErrorState(error.toString()));
      checkProductCart(id);
    }
  }

  void checkProductCart(int ProductId) {
    if (inCartsRealTime[ProductId] == true) {
      inCartsRealTime[ProductId] = false;
      emit(ChangingCartToRemoveState());
    } else {
      inCartsRealTime[ProductId] = true;
      emit(ChangingCartToSuccessState());
    }
  }

  void updateCarts(id, quantiy) async {
    emit(UpdatingCartLoadingState());
    try {
      await cartRepository.updateCarts(id, quantiy);
      emit(UpdatingCartSuccessState());
      getCarts();
    } catch (error) {
      emit(UpdatingCartErrorState(error.toString()));
    }
  }

  getCarts() async {
    emit(GettingCartLoadingState());
    try {
      cartsModel = await cartRepository.getCarts();
      emit(GettingCartSuccessState());
    } catch (error) {
      emit(GettingCartErrorState(error.toString()));
    }
  }
}
