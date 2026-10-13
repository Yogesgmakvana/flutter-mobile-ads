import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../add_helper/ad_helper.dart';

class InterstitialAdManager {
  InterstitialAd? _ad;

  void loadAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _ad = ad,
        onAdFailedToLoad: (error) {
          debugPrint('Interstitial error: $error');
        },
      ),
    );
  }

  void showAd({VoidCallback? onDismissed}) {
    final ad = _ad;
    if (ad == null) {
      onDismissed?.call();
      loadAd();
      return;
    }

    _ad = null;

    ad.fullScreenContentCallback =
        FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad) {
            ad.dispose();
            loadAd();
            onDismissed?.call();
          },
          onAdFailedToShowFullScreenContent: (ad, error) {
            ad.dispose();
            loadAd();
            onDismissed?.call();
          },
        );

    ad.show();
  }

  void dispose() {
    _ad?.dispose();
    _ad = null;
  }
}
