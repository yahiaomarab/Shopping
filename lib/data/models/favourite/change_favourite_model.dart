class ChangingProductFavouriteModel
{
  bool? status;
  dynamic message;

  ChangingProductFavouriteModel({
    required this.status,
    required this.message,
  });
  ChangingProductFavouriteModel.formjson(Map<String,dynamic>json)
  {
    status=json['status'];
    message=json['message'];
  }
}