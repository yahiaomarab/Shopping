import 'package:flutter/material.dart';
import 'package:shop_app/data/data_resource/shared_prefrence.dart';
import 'package:shop_app/presentation/login_screen/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../widgets/component/components.dart';
import '../../widgets/styles/colors/colors.dart';

class onboardingscreen extends StatefulWidget {
  @override
  State<onboardingscreen> createState() => _onboardingscreenState();
}

class _onboardingscreenState extends State<onboardingscreen> {
  void submit() {
    AdvancedSharedPreferences.setBool('boarding', true).then((value) {
      navAndReplace(context, LoginScreen());
    });
  }

  var boardController = PageController();
  bool islast = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<boardingmodel> boarding = [
      boardingmodel(
          image: 'assets/images/images.jpeg',
          body: 'shopping easy with our application',
          title: 'Shopping Today'),
      boardingmodel(
          image: 'assets/images/boarda.jpeg',
          body: 'you dont need more money',
          title: 'Comfort Shopping'),
      boardingmodel(
          image: 'assets/images/boardb.jpeg',
          body: 'discount lead to 40%',
          title: 'Black Friday'),
    ];
    return TweenAnimationBuilder(
      curve: Curves.easeIn,
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(seconds: 6),
      builder: (BuildContext context, double value, childl) => Opacity(
        opacity: value,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                  onPressed: () {
                    submit();
                  },
                  child: const Text(
                    'skip',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: boardController,
                    onPageChanged: (index) {
                      if (index == boarding.length - 1) {
                        setState(() {
                          islast = true;
                        });
                      } else {
                        setState(() {
                          islast = false;
                        });
                      }
                    },
                    itemBuilder: (context, index) =>
                        buildboardingitem(boarding[index]),
                    itemCount: boarding.length,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SmoothPageIndicator(
                      controller: boardController,
                      effect: const ExpandingDotsEffect(
                        dotWidth: 10,
                        dotHeight: 10,
                        spacing: 5,
                        activeDotColor: defaultColor,
                        dotColor: Colors.grey,
                        expansionFactor: 4,
                      ),
                      count: boarding.length,
                    ),
                    const Spacer(),
                    FloatingActionButton(
                      onPressed: () {
                        if (islast) {
                          submit();
                        } else {
                          boardController.nextPage(
                            duration: const Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );
                        }
                      },
                      child: const Icon(Icons.arrow_forward_ios),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildboardingitem(boardingmodel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage('${model.image}'),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          ' ${model.title}',
          style: const TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          '${model.body}',
          style: const TextStyle(
              fontStyle: FontStyle.italic, fontSize: 20, color: Colors.black),
        ),
      ],
    );
  }
}

class boardingmodel {
  final String image;
  final String body;
  final String title;
  boardingmodel({required this.image, required this.body, required this.title});
}
