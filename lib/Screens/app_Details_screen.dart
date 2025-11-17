import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppDetailsScreen extends StatefulWidget {
  const AppDetailsScreen({super.key});

  @override
  State<AppDetailsScreen> createState() => _AppDetailsScreenState();
}

class _AppDetailsScreenState extends State<AppDetailsScreen> {
  bool isBannerLoaded = false;
  late BannerAd bannerAd;

  @override
  void initState() {
    super.initState();
    initBannerAd();
  }

  initBannerAd() async {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: 'ca-app-pub-6551977015242048/2223447155',
        listener: BannerAdListener(onAdLoaded: (ad) {
          setState(() {
            isBannerLoaded = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
          isBannerLoaded = false;
          print(error);
        }),
        request: AdRequest());

    bannerAd.load();
  }

  @override
  void dispose() {
    bannerAd.dispose();
    super.dispose();
  }

  Widget buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '• ', // Bullet point character
          style: TextStyle(
              fontSize: 16, color: Theme.of(context).colorScheme.primary),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14, fontFamily: 'PlayfairDisplay'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: isBannerLoaded
          ? Container(
          width: width,
          height: bannerAd.size.height.toDouble(),
          color: Theme.of(context).colorScheme.background,
          child: AdWidget(ad: bannerAd))
          : Container(
              height: 0,
            ),
      appBar: AppBar(
        title: const Text('Tools and Technologies'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Three images side by side
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5_5OlDNfwxM_DOmrycgLuo4Pwx2teQrk3EQ&s',
                      width: 80,
                      height: 100,
                    ),
                    Image.network(
                      'https://i.ytimg.com/vi/ySmWlU9j3j4/maxresdefault.jpg',
                      width: 100,
                      height: 100,
                    ),
                    Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjTjeNHyqBHdImqGDutRVJ02tBUSDXaZfgtg&s',
                      width: 100,
                      height: 100,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Flutter",
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              buildBulletPoint(
                  "Flutter allows developers to build natively compiled applications for mobile, web, and desktop from a single codebase, reducing development time and effort."),
              const SizedBox(height: 5),
              buildBulletPoint(
                  "It provides a comprehensive collection of customizable widgets and tools that facilitate expressive and adaptive user interfaces."),
              const SizedBox(height: 20),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Firebase",
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              buildBulletPoint(
                  "Firebase offers real-time data synchronization with Firebase Realtime Database and Cloud Firestore, enabling seamless and instantaneous updates across all connected clients."),
              const SizedBox(height: 5),
              buildBulletPoint(
                  "Firebase provides built-in authentication services for secure user sign-in and integrated analytics tools to track user behavior and app performance, simplifying backend management and insights."),
              const SizedBox(height: 20),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "PokeApi",
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              buildBulletPoint(
                  "PokeAPI offers detailed information about Pokémon, including stats, abilities, types, and evolutions, making it a rich resource for accessing extensive Pokémon-related data."),
              const SizedBox(height: 5),
              buildBulletPoint(
                  "It provides a RESTful interface for querying data, allowing developers to easily integrate Pokémon information into applications and websites using simple HTTP requests."),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
