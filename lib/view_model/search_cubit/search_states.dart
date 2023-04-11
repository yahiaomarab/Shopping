abstract class SearchStates {}

class IntialState extends SearchStates {}

class SearchingDataLoading extends SearchStates {}

class SearchingDataSuccess extends SearchStates {}

class SearchingDataErorr extends SearchStates {
  final erorr;
  SearchingDataErorr(this.erorr);
}
