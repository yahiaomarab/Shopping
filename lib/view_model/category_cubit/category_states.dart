abstract class CategoryStates{}

class IntialState extends CategoryStates{}

class GettingCategoriesDataLoading extends CategoryStates{}

class GettingCategoriesDataSuccess extends CategoryStates{}
class GettingCategoriesDataErorr extends CategoryStates{
  final erorr;
  GettingCategoriesDataErorr(this.erorr);
}