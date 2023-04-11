abstract class HomeStates{}

class IntialState extends HomeStates{}

class GettingHomeDataLoading  extends HomeStates{}
class GettingHomeDataSuccess  extends HomeStates{}
class GettingHomeDataErorr  extends HomeStates{
  final erorr;
  GettingHomeDataErorr(this.erorr);
}
class GettingHomeProductDataLoading extends HomeStates{}
class GettingHomeProductDataSuccess extends HomeStates{}
class GettingHomeProductDataErorr extends HomeStates{
  final erorr;
  GettingHomeProductDataErorr(this.erorr);
}