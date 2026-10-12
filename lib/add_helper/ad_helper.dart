
import 'dart:io' show Platform;

class AdHelper {
  static String get bannerAdUnitId =>
      Platform.isAndroid
          ? 'ca-app-pub-5504068557345307/1784343542'
          : 'ca-app-pub-5504068557345307/7894456323';

  static String get interstitialAdUnitId =>
      Platform.isAndroid
          ? 'ca-app-pub-5504068557345307/6050891619'
          : 'ca-app-pub-3940256099942544/4411468910';

  static String get rewardedAdUnitId =>
      Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/5224354917'
          : 'ca-app-pub-3940256099942544/1712485313';

  static String get rewardedInterstitialAdUnitId =>
      Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/5354046379'
          : 'ca-app-pub-3940256099942544/6978759866';

  static String get nativeAdUnitId =>
      Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/2247696110'
          : 'ca-app-pub-3940256099942544/3986624511';

  static String get appOpenAdUnitId =>
      Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/9257395921'
          : 'ca-app-pub-3940256099942544/5575463023';
}
