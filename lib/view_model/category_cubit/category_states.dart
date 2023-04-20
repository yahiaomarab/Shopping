abstract class CategoryStates{}

class IntialState extends CategoryStates{}

class GettingCategoriesDataLoading extends CategoryStates{}

class GettingCategoriesDataSuccess extends CategoryStates{}
class GettingCategoriesDataErorr extends CategoryStates{
  final erorr;
  GettingCategoriesDataErorr(this.erorr);
}
class GettingCatDataLoading extends CategoryStates{}

class GettingCatDataSuccess extends CategoryStates{}
class GettingCatDataErorr extends CategoryStates{
  final erorr;
  GettingCatDataErorr(this.erorr);
}