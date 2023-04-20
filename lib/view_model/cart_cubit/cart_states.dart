import '../../data/models/carts/cart_model.dart';

abstract class CartStates {}

class InitialState extends CartStates {}

class ChangingCartLoadingState extends CartStates {}

class ChangingCartSuccessState extends CartStates {
  final InCartsModel? inCartsModel;
  ChangingCartSuccessState(this.inCartsModel);
}
class ChangingCartToSuccessState extends CartStates{}
class ChangingCartToRemoveState extends CartStates{}


class ChangingCartErrorState extends CartStates {
  final String error;
  ChangingCartErrorState(this.error);
}

class UpdatingCartLoadingState extends CartStates {}

class UpdatingCartSuccessState extends CartStates {}

class UpdatingCartErrorState extends CartStates {
  final String error;
  UpdatingCartErrorState(this.error);
}

class GettingCartLoadingState extends CartStates {}

class GettingCartSuccessState extends CartStates {}

class GettingCartErrorState extends CartStates {
  final String error;
  GettingCartErrorState(this.error);
}
