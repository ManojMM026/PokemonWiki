import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  Future<InitializationStatus> initialization;

  AdHelper(this.initialization);

  static const String androidId =
      "ca-app-pub-3940256099942544/6300978111"; //test app id
  static const String iosId =
      "ca-app-pub-3940256099942544/2934735716"; //test app id

  static String get bannerAdUnitId {
    print("Add id : " + androidId);
    print("Add ios id : " + iosId);
    if (Platform.isAndroid) {
      return androidId;
    } else if (Platform.isIOS) {
      return iosId;
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  printAddId() {
    print('Add id ${AdHelper.bannerAdUnitId}');
  }
}
