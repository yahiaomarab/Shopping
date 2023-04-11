abstract class UserStates {}

class IntialState extends UserStates {}

class GettingProfileDataSuccess extends UserStates {}

class GettingProfileDataLoading extends UserStates {}

class GettingProfileDataErorr extends UserStates {
  final erorr;
  GettingProfileDataErorr(this.erorr);
}

class UpdatingProfileDataLoading extends UserStates {}

class UpdatingProfileDataSuccess extends UserStates {}

class UpdatingProfileDataErorr extends UserStates {
  final erorr;
  UpdatingProfileDataErorr(this.erorr);
}

class ChangingBottomIndexState extends UserStates {}
