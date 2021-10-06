
import 'package:flutter/material.dart';

// TODO: Import google_mobile_ads.dart
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:menafn/ad_helper.dart';


class NativeInlinePage extends StatefulWidget {
  @override
  _NativeInlinePageState createState() => _NativeInlinePageState();
}
class _NativeInlinePageState extends State<NativeInlinePage> {

  bool isAdLoaded = false;
  NativeAdListener listener;

 List<Object> itemList=[];
  // TODO: Add a NativeAd instance


  // TODO: Add _isAdLoaded


  NativeAd myNative;

 @override
 void initState() {


   super.initState();
   myNative = NativeAd(
     adUnitId: AdHelper.nativeAdUnitId,
     factoryId: 'listTile',
     request: AdRequest(),
     listener:
     NativeAdListener(
       // Called when an ad is successfully received.
       onAdLoaded: (Ad ad) => {
         setState(() {
           isAdLoaded = true;
         })
       },
       // Called when an ad request failed.
       onAdFailedToLoad: (Ad ad, LoadAdError error) {
         // Dispose the ad here to free resources.
         ad.dispose();
         print('NativeAd failed to load: $error');
       },
       // Called when an ad opens an overlay that covers the screen.
       onAdOpened: (Ad ad) => print('Ad opened.'),
       // Called when an ad removes an overlay that covers the screen.
       onAdClosed: (Ad ad) => print('Ad closed.'),
       // Called when an impression occurs on the ad.
       onAdImpression: (Ad ad) => print('Ad impression.'),
       // Called when a click is recorded for a NativeAd.
       onNativeAdClicked: (NativeAd ad) => print('Ad clicked.'),
     ),
   );

   myNative.load();
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
    child: isAdLoaded ? AdWidget(ad: myNative) : CircularProgressIndicator(color:Color(0xff88db52)),
    height: 240,
    alignment: Alignment.center,
    ),
    );
  }
}