import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pokedex/Screens/splash_screen.dart';
import 'package:pokedex/firebase_options.dart';
import 'package:pokedex/network/firebase_notification_api.dart';
import 'package:wiredash/wiredash.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseNotificationApi().initNotifications();
  runApp( ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.black,
    hintColor: Colors.blueAccent,
  );

  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    hintColor: Colors.blueGrey,
  );

  @override
  Widget build(BuildContext context) {
    return  Wiredash(
      projectId: '',
      secret: '',
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.system,
          home: const SplashScreen()),
    );
  }
}
