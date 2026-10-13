import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../add_helper/ad_helper.dart';

class RewardedAdManager {
  RewardedAd? _rewardedAd;
  bool _isAdLoading = false;

  void loadAd() {
    if (_rewardedAd != null || _isAdLoading) return;
    _isAdLoading = true;

    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isAdLoading = false;
          debugPrint('Rewarded ad loaded successfully.');
        },
        onAdFailedToLoad: (error) {
          debugPrint('Rewarded ad failed to load: $error');
          _rewardedAd = null;
          _isAdLoading = false;
        },
      ),
    );
  }

  void showAd({
    required Function(RewardItem reward) onUserEarnedReward,
    VoidCallback? onAdDismissed,
  }) {
    final ad = _rewardedAd;
    if (ad == null) {
      debugPrint('Rewarded ad is not ready yet.');
      loadAd();
      return;
    }

    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _rewardedAd = null;
        loadAd();
        onAdDismissed?.call();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('Rewarded ad failed to show: $error');
        ad.dispose();
        _rewardedAd = null;
        loadAd();
        onAdDismissed?.call();
      },
    );

    ad.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        onUserEarnedReward(reward);
      },
    );

    _rewardedAd = null;
  }

  bool get isAdLoaded => _rewardedAd != null;

  void dispose() {
    _rewardedAd?.dispose();
    _rewardedAd = null;
  }
}
