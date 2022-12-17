import 'package:flutter/cupertino.dart';

class slideright extends PageRouteBuilder
{
  final page;
  slideright({this.page}) : super(

      pageBuilder: (context,animation,animationtwo)=>page,
    transitionsBuilder: (context,animation,animationtwo,child)
    {
      var begin=Offset(1,0);
      var end =Offset(0,0);
      var tween=Tween(begin:begin ,end:end );
      var offestanimation=animation.drive(tween);
      return SlideTransition(position: offestanimation,child: child,) ;
    },
  );

}
class slideauto extends PageRouteBuilder
{
  final page;
  slideauto({this.page}) : super(

    pageBuilder: (context,animation,animationtwo)=>page,
    transitionsBuilder: (context,animation,animationtwo,child)
    {
      var begin=0.0;
      var end =1.0;
      var tween=Tween(begin:begin ,end:end );
      var curvedanimation=CurvedAnimation(parent: animation, curve: Curves.easeInBack);
      return ScaleTransition(scale:tween.animate( curvedanimation),child: child,) ;
    },
  );

}
class slidetwoanime extends PageRouteBuilder
{
  final page;
  slidetwoanime({this.page}) : super(

    pageBuilder: (context,animation,animationtwo)=>page,
    transitionsBuilder: (context,animation,animationtwo,child)
    {
      var begin=0.0;
      var end =1.0;
      var tween=Tween(begin:begin ,end:end );
      var curvedanimation=CurvedAnimation(parent: animation, curve: Curves.easeInBack);
      return ScaleTransition(scale:tween.animate( curvedanimation),child: RotationTransition(turns:tween.animate(curvedanimation),child: child,),) ;
    },
  );

}

