import 'package:shop_app/modules/shopapp/login/shoplogin.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

String uid='';
String token='';
void signout(context)
{
  cachehelper.removedata(key: 'token');
  navandreplace(context, shoplogin());
}