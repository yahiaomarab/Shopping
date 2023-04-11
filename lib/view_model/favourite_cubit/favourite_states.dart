abstract class FavouriteStates{}

class IntialState extends FavouriteStates{}

class GettingFavouriteProductDataLoading extends FavouriteStates{}
class GettingFavouriteProductDataSuccess extends FavouriteStates{}
class GettingFavouriteProductDataErorr extends FavouriteStates{
  final erorr;
  GettingFavouriteProductDataErorr(this.erorr);
}
class ChangingProductFavouriteLoading extends FavouriteStates{}
class ChangingProductFavouriteSuccess extends FavouriteStates{}
class ChangingProductFavouriteErorr extends FavouriteStates{
  final erorr;
  ChangingProductFavouriteErorr(this.erorr);
}
