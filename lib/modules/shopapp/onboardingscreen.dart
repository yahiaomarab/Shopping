import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/shopapp/login/shoplogin.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class onboardingscreen extends StatefulWidget
{
  @override
  State<onboardingscreen> createState() => _onboardingscreenState();
}

class _onboardingscreenState extends State<onboardingscreen> {
  void submit()
  {
    cachehelper.savedata(key: 'boarding', value: true).then
      ((value) {
         if(value)
          {
            navandreplace(
                context,
                shoplogin()
            );
         }
       });
  }
var boardController=PageController();
bool islast=false;
@override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<boardingmodel>boarding=[
      boardingmodel(image: 'assets/images/images.jpeg', body: 'shopping easy with our application', title: 'Shopping Today'),
      boardingmodel(image: 'assets/images/boarda.jpeg', body: 'you dont need more money', title: 'Comfort Shopping'),
      boardingmodel(image: 'assets/images/boardb.jpeg', body: 'discount lead to 40%', title: 'Black Friday'),
    ];
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
                     onPressed: (){
                       submit();
                        },
              child: Text('skip',
          style: TextStyle(
            fontSize: 15,
          ),))
        ],
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    physics: BouncingScrollPhysics(),
                      controller: boardController,
                      onPageChanged: (index) {
                        if (index == boarding.length - 1) {
                        setState  ((){
                          islast=true;
                        });
                        }else
                          {
                            setState  ((){
                              islast=false;
                            });
                          }
                      },
                      itemBuilder: (context,index)=>buildboardingitem(boarding[index]),
                    itemCount: boarding.length,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                   SmoothPageIndicator(
                     controller: boardController,
                       effect: ExpandingDotsEffect(
                         dotWidth: 10,
                         dotHeight: 10,
                         spacing: 5,

                         activeDotColor: defaultcolor,
                         dotColor: Colors.grey,
                         expansionFactor: 4,
                       ),
                       count: boarding.length,
                   ),
                    Spacer(),
                    FloatingActionButton(
                      onPressed: (){
                        if (islast)
                          {
                            submit();
                          }else
                       {
                         boardController.nextPage(
                           duration: Duration(
                             milliseconds: 750,
                           ),
                           curve: Curves.fastLinearToSlowEaseIn,
                         );
                       }
                      },
                        child: Icon(Icons.arrow_forward_ios),
                    )
                  ],
                ),

          ],
        ),
      ),
    );
  }

  Widget buildboardingitem(boardingmodel model)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage('${model.image}'),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
         ' ${model.title}',

          style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          '${model.body}',

          style: TextStyle(
              fontStyle:FontStyle.italic,
              fontSize: 20,
              color: Colors.black
          ),
        ),
      ],
    );
  }
}
class boardingmodel
{
  final String image;
  final String body;
  final String title;
  boardingmodel({required this.image,required this.body,required this.title});

}

