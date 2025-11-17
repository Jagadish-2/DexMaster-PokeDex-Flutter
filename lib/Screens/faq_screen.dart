import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pokedex/model/faqModel.dart';

class FaqScreen extends StatefulWidget{
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
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
     appBar: AppBar(title: const Text('FAQ Section'),
     backgroundColor: Theme.of(context).colorScheme.inversePrimary,
     ),
     body: ListView.builder(itemCount: faqlist.length,
         itemBuilder: (context,index){
       return ExpansionTile(title: Text(faqlist[index].question),
       backgroundColor: Colors.purpleAccent.withOpacity(0.1),
       children: <Widget>[
         Padding(padding: const EdgeInsets.all(16),
         child: Text(faqlist[index].answer),
         )
       ],
       );
         }),
   );
  }
}