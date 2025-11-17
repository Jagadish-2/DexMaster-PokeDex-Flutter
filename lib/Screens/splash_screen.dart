import 'dart:async';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String _randomImage;
  String appVersion = "";
  String appBuildNumber = '';

  _SplashScreenState() {
    initAppVersion();
  }

  @override
  void initState() {
    super.initState();
    _randomImage = _getRandomImage();
    Timer(
      const Duration(seconds: 1),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FirebaseAuth.instance.currentUser != null
                ? HomeScreen()
                : LoginScreen(),
          ),
        );
      },
    );
  }

  String _getRandomImage() {
    final List<String> images = [
      'assets/images/SplashScreen/splash_screen_2.jpg',
      'assets/images/SplashScreen/splash_screen_3.jpg',
      'assets/images/SplashScreen/splash_screen_4.jpg',
      'assets/images/SplashScreen/splash_screen_5.jpg',
      'assets/images/SplashScreen/splash_screen_7.jpg',
      'assets/images/SplashScreen/splash_screen_8.jpg',
      'assets/images/SplashScreen/splash_screen_12.jpg',
      'assets/images/SplashScreen/splash_screen_13.jpg',
      'assets/images/SplashScreen/splash_screen_14.jpg',
      'assets/images/SplashScreen/splash_screen_17.jpg',
      'assets/images/SplashScreen/splash_screen_18.jpg',
      'assets/images/SplashScreen/splash_screen_20.jpg',
    ];
    final Random random = Random();
    return images[random.nextInt(images.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(_randomImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              // Background color with opacity
              borderRadius: BorderRadius.circular(20),
              // Rounded corners with a radius of 20
              border: Border.all(
                color: Colors.black, // Border color
                width: 2, // Border width
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    appVersion,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors
                          .transparent, // Remove background color from text
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Developed Using: Flutter\n'
                    '  AppVersion code :  ${appBuildNumber}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors
                          .transparent, // Remove background color from text
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }

  void initAppVersion() async {
    await PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        appVersion = "v${packageInfo.version}";
        appBuildNumber = 'v${packageInfo.buildNumber}';
      });
    });
  }
}
