import 'dart:io';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1786942026589567/3740558323';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-1786942026589567/9480725583';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return ' ca-app-pub-1786942026589567/4862068304';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-1786942026589567/4152377284';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1786942026589567/2044333277';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/7552160883';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }
  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1786942026589567/8014899157';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-1786942026589567/7335010408';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }
}


