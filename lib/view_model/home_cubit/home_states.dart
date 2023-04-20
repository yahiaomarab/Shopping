abstract class HomeStates {}

class IntialState extends HomeStates {}

class GettingHomeDataLoading extends HomeStates {}

class GettingHomeDataSuccess extends HomeStates {}

class GettingHomeDataErorr extends HomeStates {
  final erorr;
  GettingHomeDataErorr(this.erorr);
}
