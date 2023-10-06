import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/sheard/components/components.dart';
import 'package:shop_app/sheard/styles/colors/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoadingModel {
  final String image;
  final String title;
  final String body;

  BoadingModel({required this.image, required this.title, required this.body});
}

class OnBordingScreen extends StatefulWidget {
  const OnBordingScreen({super.key});

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  bool isLast = false;
  var boardController = PageController();

  List<BoadingModel> boarding = [
    BoadingModel(
        image: 'assets/images/women.webp',
        title: 'on Board 1 Title',
        body: 'on Board 1 Body'),
    BoadingModel(
        image: 'assets/images/m2.jpg',
        title: 'on Board 2 Title',
        body: 'on Board 2 Body'),
    BoadingModel(
        image: 'assets/images/m3.jpg',
        title: 'on Board 3 Title',
        body: 'on Board 3 Body'),
    BoadingModel(
        image: 'assets/images/m1.jpg',
        title: 'on Board 4 Title',
        body: 'on Board 4 Body'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              navigateAndFinish(
                context,
                const LogInScreen(),
              );
            },
            child: const Text('Skip'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    print(isLast);
                    print('حفففف');
                    if (isLast == true) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LogInScreen(),
                          ));

                      print('object');
                    } else {
                      boardController.nextPage(
                          duration: const Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastEaseInToSlowEaseOut);
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoadingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(model.image),
              // width: 200.0,
            ),
          ),
          const SizedBox(
            height: 30.2,
          ),
          Text(
            model.title,
            style: const TextStyle(
              fontSize: 24.0,
            ),
          ),
          const SizedBox(
            height: 15.2,
          ),
          Text(
            model.body,
            style: const TextStyle(
              fontSize: 15.0,
            ),
          ),
        ],
      );
}
