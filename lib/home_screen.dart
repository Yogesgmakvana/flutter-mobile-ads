
import 'package:flutter/material.dart';
import 'ads/banner_ad_widget.dart';
import 'ads/interstitial_ad_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final InterstitialAdManager interstitial =
  InterstitialAdManager();

  @override
  void initState() {
    super.initState();

    // Load interstitial ad when screen opens
    interstitial.loadAd();
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

  @override
  void dispose() {
    interstitial.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
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
          ],
        ),
      ),
    );
  }
}
