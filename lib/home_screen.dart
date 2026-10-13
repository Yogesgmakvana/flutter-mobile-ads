import 'package:flutter/material.dart';
import 'ads/banner_ad_widget.dart';
import 'ads/interstitial_ad_manager.dart';
import 'ads/rewarded_ad_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final InterstitialAdManager interstitial = InterstitialAdManager();
  final RewardedAdManager rewardedAdManager = RewardedAdManager();

  int coins = 0;

  @override
  void initState() {
    super.initState();

    // Load interstitial and rewarded ads when screen opens
    interstitial.loadAd();
    rewardedAdManager.loadAd();
  }

  void onNextButtonPressed() {
    interstitial.showAd(
      onDismissed: () {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Interstitial ad closed'),
          ),
        );
      },
    );
  }

  void onWatchAdButtonPressed() {
    if (!rewardedAdManager.isAdLoaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ad is loading, please try again in a moment.'),
        ),
      );
      rewardedAdManager.loadAd();
      return;
    }

    rewardedAdManager.showAd(
      onUserEarnedReward: (reward) {
        if (!mounted) return;

        setState(() {
          coins += 10;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Congratulations! You earned 10 coins!'),
          ),
        );
      },
      onAdDismissed: () {
        // Ad dismissed callback
      },
    );
  }

  @override
  void dispose() {
    interstitial.dispose();
    rewardedAdManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                const Icon(Icons.monetization_on, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  '$coins Coins',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: BannerAdWidget(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onNextButtonPressed,
              child: const Text('Interstitial Ads'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onWatchAdButtonPressed,
              child: const Text('watch vedio and earn 10 coin'),
            ),
          ],
        ),
      ),
    );
  }
}
