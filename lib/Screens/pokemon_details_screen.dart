import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pokedex/widgets/custom_pokemon_details_widget.dart';

class PokemonDetailsScreen extends StatefulWidget {
  final pokemonDetails;
  final Color color;
  final int heroTag;

  const PokemonDetailsScreen({
    super.key,
    this.pokemonDetails,
    required this.color,
    required this.heroTag,
  });

  @override
  State<PokemonDetailsScreen> createState() => _PokemonDetailsScreenState();
}

class _PokemonDetailsScreenState extends State<PokemonDetailsScreen> {
  bool isBannerLoaded = false;
  late BannerAd bannerAd;

  initBannerAd() async {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: 'ca-app-pub-6551977015242048/2223447155',
        listener: BannerAdListener(
          onAdLoaded: (ad){
            setState(() {
              isBannerLoaded = true;
            });
          },
          onAdFailedToLoad: (ad,error){
            ad.dispose();
            isBannerLoaded =false;
            print(error);
          }
        ),
        request: AdRequest());

    bannerAd.load();
  }

  @override
  void initState() {
    super.initState();
    initBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: isBannerLoaded
          ? Container(
        decoration: const BoxDecoration(color: Colors.white),
        height: bannerAd.size.height.toDouble(),
        child: AdWidget(ad: bannerAd),
      )
          : Container(height: 0),
      backgroundColor: widget.color,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 30,
            left: 10,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                )),
          ),
          Positioned(
              top: 80,
              left: 20,
              child: Text(
                widget.pokemonDetails['name'],
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
          Positioned(
            top: 130,
            left: 20,
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.black26),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                child: Text(
                  widget.pokemonDetails['type'].join(' , '),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.18,
            right: -30,
            child: Image.asset(
              'assets/images/pokeball_white.png',
              height: 200,
              fit: BoxFit.fitHeight,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: height * 0.6,
              width: width,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       Container(
                    //           width: width * 0.3,
                    //           child: Text("Name",style: TextStyle(color: Colors.blueGrey,fontSize: 18),),
                    //
                    //       ),
                    //       Container(
                    //         width: width * 0.3,
                    //         child: Text(widget.pokemonDetails['name'],style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                    //
                    //       ),
                    //
                    //     ],
                    //   ),
                    // ),
                    CustomPokemonDetailsWidget(
                      width: width,
                      pokemonDetails: widget.pokemonDetails['name'],
                      name: 'Name',
                    ),
                    CustomPokemonDetailsWidget(
                      width: width,
                      pokemonDetails: widget.pokemonDetails['height'],
                      name: 'Height',
                    ),
                    CustomPokemonDetailsWidget(
                      width: width,
                      pokemonDetails: widget.pokemonDetails['weight'],
                      name: 'Weight',
                    ),
                    CustomPokemonDetailsWidget(
                      width: width,
                      pokemonDetails: widget.pokemonDetails['spawn_time'],
                      name: 'Spawn Time',
                    ),
                    CustomPokemonDetailsWidget(
                      width: width,
                      pokemonDetails:
                          widget.pokemonDetails['weaknesses'].join(' , '),
                      name: 'Weaknesses',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width * 0.3,
                            child: const Text(
                              "Prev_Form",
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 18),
                            ),
                          ),
                          widget.pokemonDetails['prev_evolution'] != null
                              ? SizedBox(
                                  height: 20,
                                  width: width * 0.55,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: widget
                                          .pokemonDetails['prev_evolution']
                                          .length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Text(
                                            widget.pokemonDetails[
                                                    'prev_evolution'][index]
                                                ['name'],
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        );
                                      }),
                                )
                              : const Text(
                                  "Just Hatched",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width * 0.3,
                            child: const Text(
                              "Evolution",
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 18),
                            ),
                          ),
                          widget.pokemonDetails['next_evolution'] != null
                              ? SizedBox(
                                  height: 24,
                                  width: width * 0.55,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: widget
                                          .pokemonDetails['next_evolution']
                                          .length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Text(
                                            widget.pokemonDetails[
                                                    'next_evolution'][index]
                                                ['name'],
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        );
                                      }),
                                )
                              : const Text(
                                  "Maxed Out",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: (height * 0.18),
              left: (width / 2) - 100,
              child: Hero(
                tag: widget.heroTag,
                child: CachedNetworkImage(
                  imageUrl: widget.pokemonDetails['img'],
                  height: 200,
                  fit: BoxFit.fitHeight,
                ),
              ))
        ],
      ),
    );
  }
}
