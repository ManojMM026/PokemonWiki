import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mypokedex/util/add_helper.dart';
import 'package:mypokedex/widget/text_util.dart';
import 'package:provider/provider.dart';

class BannerAdWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BannerAdState();
}

class BannerAdState extends State<BannerAdWidget> {
  BannerAd _bannerAd;
  final Completer<BannerAd> bannerCompleter = Completer<BannerAd>();

  @override
  void initState() {
    super.initState();
    _initAddBanner();
  }

  void _initAddBanner() {
    final addState = Provider.of<AdHelper>(context, listen: false);
    addState.printAddId();
    try {
      addState.initialization.then((status) {
        _bannerAd = BannerAd(
          adUnitId: AdHelper.bannerAdUnitId,
          request: AdRequest(),
          size: AdSize.banner,
          listener: BannerAdListener(
            onAdLoaded: (Ad ad) {
              print('$BannerAd loaded.');
              bannerCompleter.complete(ad as BannerAd);
            },
            onAdFailedToLoad: (Ad ad, LoadAdError error) {
              ad.dispose();
              print('$BannerAd failedToLoad: $error');
              bannerCompleter.completeError(error);
            },
            onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
            onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
            // onApplicationExit: (Ad ad) => print('$BannerAd onApplicationExit.'),
          ),
        );
        Future<void>.delayed(Duration(seconds: 1), () => _bannerAd.load());
      }, onError: (e) {
        print('Error in add banner init onError $e');
      });
    } catch (e) {
      print('Error in add banner init $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (_bannerAd != null) {
      _bannerAd.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BannerAd>(
      future: bannerCompleter.future,
      builder: (BuildContext context, AsyncSnapshot<BannerAd> snapshot) {
        Widget child;

        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            child = Container();
            break;
          case ConnectionState.done:
            if (snapshot.hasData) {
              child = AdWidget(ad: _bannerAd);
            } else {
              child = Center(child: subtitle2(context,'Error loading $BannerAd'));
            }
        }

        return Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          color: Colors.white,
          child: child,
        );
      },
    );
  }
}
