abstract class ProductStates {}

class IntialState extends ProductStates {}

class GettingProductDataLoading extends ProductStates {}

class GettingProductDataSuccess extends ProductStates {}

class GettingProductDataError extends ProductStates {
  final String error;
  GettingProductDataError(this.error);
}
