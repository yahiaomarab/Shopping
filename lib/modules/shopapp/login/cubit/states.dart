

abstract class logappstates {}
class intialloginstate extends logappstates{}
class loginloadingstate extends logappstates{}
class loginsucessstate extends logappstates{}
class loginerorrstate extends logappstates{
  final String erorr;

  loginerorrstate(this.erorr);
}
class loginiconchangestate extends logappstates{}