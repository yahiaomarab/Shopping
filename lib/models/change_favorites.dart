class changefavoritesmodel
{
   bool? status;
   dynamic message;

  changefavoritesmodel({
    required this.status,
    required this.message,
  });
  changefavoritesmodel.formjson(Map<String,dynamic>json)
  {
    status=json['status'];
    message=json['message'];
  }
}


