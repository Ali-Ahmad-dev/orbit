import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/widgets/hr_circularprogressindicator.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashScreenController controller = Get.put(SplashScreenController());

  @override
  void initState() {
    super.initState();
    controller.initializeApp(); // Call a method in your controller for initialization
  }

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.03,
            vertical: height * 0.03,
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: HrCircularprogressindicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
