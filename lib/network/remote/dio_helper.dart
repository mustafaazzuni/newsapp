// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:menafn_dev/models/saveartical.dart';
// import 'package:menafn_dev/service/const.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
// import 'package:admob_flutter/admob_flutter.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// //import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
// import 'package:menafn_dev/screens/article_view.dart';
// import 'package:share/share.dart';
// import 'package:firebase_admob/firebase_admob.dart';
// import 'package:flutter_native_admob/flutter_native_admob.dart';
// import 'package:flutter_native_admob/native_admob_controller.dart';
//
// import '../adsManager.dart';
//
// class PhotosListScreen extends StatefulWidget {
//   PhotosListScreen({Key key}) : super(key: key);
//
//   @override
//   _PhotosListScreenState createState() => _PhotosListScreenState();
// }
//
// class _PhotosListScreenState extends State<PhotosListScreen> {
//   static const _adUnitID = "ca-app-pub-1786942026589567/7335010408";
//   //final _nativeAdController = NativeAdmobController();
//   double _height = 0;
//   StreamSubscription _subscription;
//
//   final _nativeAdController = NativeAdmobController();
// // Language _language = Language();
//
//   AdmobBannerSize bannerSize;
//   AdmobInterstitial interstitialAd;
//
//   @override
//   void initState() {
//     super.initState();
//     StartData();
//     initDb();
//
//     //Ads
//     interstitialAd = AdmobInterstitial(
//       adUnitId: AdsManager.interstitialAdUnitId,
//       listener: (AdmobAdEvent event, Map<String, dynamic> args) {
//         // if (event == AdmobAdEvent.closed) interstitialAd.load();
//       },
//     );
//
//     interstitialAd.load();
//     _nativeAdController.reloadAd(forceRefresh: true);
//   }
//   // createReawrdAdAndLoad() {
//   //   RewardedVideoAd.instance.load(
//   //       adUnitId:"ca-app-pub-1786942026589567/4152377284",
//   //       targetingInfo: MobileAdTargetingInfo()  );
//   //   RewardedVideoAd.instance.listener =
//   //       (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
//   //     switch (event) {
//   //       case RewardedVideoAdEvent.rewarded:
//
//   //       ///
//   //         break;
//   //       default:
//   //     }
//   //     print(
//   //         "*createReawrdAdAndLoad $event*");
//   //   };
//   // }
//   List<Photo> fetchedHome = [];
//   List<Photo> fetchedPolitics = [];
//   List<Photo> fetchedCrypto = [];
//   List<Photo> fetchedTelecom = [];
//   List<Photo> fetchedEnergy = [];
//   List<Photo> fetchedHealth = [];
//   List<Photo> fetchedEntertainment = [];
//   List<Photo> fetchedSports = [];
//
//   Database database;
//   Widget getTelecom() {
//     if (fetchedTelecom == null) {
//       if (_loadingTelecom) {
//         return Center(
//             child: Padding(
//               padding: const EdgeInsets.all(8),
//               child: CircularProgressIndicator(),
//             ));
//       } else if (_errorTelecom) {
//         return Center(
//           child: InkWell(
//             onTap: () => setState(
//                   () {
//                 _loadingTelecom = true;
//                 _errorTelecom = false;
//                 fetchTelecom();
//               },
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Text("Error while loading photos, tap to try agin"),
//             ),
//           ),
//         );
//       }
//     } else {
//       return RefreshIndicator(
//         onRefresh: RefreshTelecom,
//         // return null;
//         child: ListView.builder(
//           itemCount: fetchedTelecom.length + (_hasMoreTelecom ? 1 : 0),
//           itemBuilder: (context, index) {
//             if (index == fetchedTelecom.length - _nextPageThresholdTelecom) {
//               fetchTelecom();
//             }
//             if (index == fetchedTelecom.length) {
//               if (_errorTelecom) {
//                 return Center(
//                   child: InkWell(
//                     onTap: () => setState(
//                           () {
//                         _loadingTelecom = true;
//                         _errorTelecom = false;
//                         fetchTelecom();
//                       },
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
//                       child:
//                       Text("Error while loading photos, tap to try agin"),
//                     ),
//                   ),
//                 );
//               } else {
//                 return Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8),
//                     child: CircularProgressIndicator(),
//                   ),
//                 );
//               }
//             }
//             final Photo photo = fetchedTelecom[index];
//             return Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => StoryView(
//                               storyId: photo.newsid.toString(),
//                             )));
//                   },
//                   child: Card(
//                     margin: const EdgeInsets.symmetric(horizontal: 0.0),
//                     child: Column(
//                       children: [
//                         Container(
//                           width: double.infinity,
//                           height: 250,
//                           decoration: BoxDecoration(
//                               image: DecorationImage(
//                                 image: NetworkImage(photo.picture),
//                                 fit: BoxFit.contain,
//
//                                 // fit: BoxFit.fill,
//                               )),
//                           child: Align(
//                             alignment: Alignment.bottomCenter,
//                             child: Container(
//                               width: MediaQuery.of(context).size.width,
//                               padding: const EdgeInsets.all(20),
//                               decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                       begin: Alignment.topCenter,
//                                       end: Alignment.bottomCenter,
//                                       colors: [
//                                         Colors.transparent.withOpacity(0),
//                                         Colors.black.withOpacity(0.5),
//                                         Colors.black.withOpacity(1),
//                                       ])),
//                               child: Text(
//                                 photo.title,
//                                 style: TextStyle(
//                                   // fontWeight: FontWeight.bold,
//                                     fontSize: 22,
//                                     color: Colors.white),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             IconButton(
//                               icon: Icon(Icons.share),
//                               color: Colors.grey,
//                               onPressed: () {
//                                 Share.share(
//                                     'check out this news ' +
//                                         fetchedTelecom[index].link,
//                                     subject: fetchedTelecom[index].title);
//                               },
//                             ),
//                             /* IconButton(
//                           icon: Icon(Icons.bookmark_border),
//                           color: Colors.grey,
//                          /* onPressed: () async{
//                             final box = GetStorage();
//                             print(box.read('bookmark'));
//                             List<dynamic> list=box.read('bookmark');
//                             if(list!=null){
//                               list.add(photo);
//                               await box.write('bookmark', list);
//                             }else{
//                               list=[];
//                               list.add(photo);
//                               await box.write('bookmark', list);
//                             }
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => BokkmarksScreen()));
//                           },*/
//                         ),*/
//                           ],
//                         ),
//                         // if (index %5==0)
//                         //   Container(
//                         //     height: _height,
//                         //     padding: EdgeInsets.all(10),
//                         //     margin: EdgeInsets.only(bottom: 20.0),
//                         //     child: NativeAdmob(
//                         //       // Your ad unit id
//                         //       adUnitID: _adUnitID,
//                         //       controller: _nativeAdController,
//
//                         //       // Don't show loading widget when in loading state
//                         //       loading: Container(),
//                         //     ),
//                         //   ),
//                       ],
//                     ),
//                   ),
//                 ));
//           },
//         ),
//       );
//     }
//     return Container();
//   }
//
//   Widget getEnergy() {
//     if (fetchedEnergy == null) {
//       if (_loadingEnergy) {
//         return Center(
//             child: Padding(
//               padding: const EdgeInsets.all(8),
//               child: CircularProgressIndicator(),
//             ));
//       } else if (_errorEnergy) {
//         return Center(
//           child: InkWell(
//             onTap: () => setState(
//                   () {
//                 _loadingEnergy = true;
//                 _errorEnergy = false;
//                 fetchEnergy();
//               },
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Text("Error while loading photos, tap to try agin"),
//             ),
//           ),
//         );
//       }
//     } else {
//       return RefreshIndicator(
//         onRefresh: RefreshEnergy,
//         // return null;
//         child: ListView.builder(
//           itemCount: fetchedEnergy.length + (_hasMoreEnergy ? 1 : 0),
//           itemBuilder: (context, index) {
//             if (index == fetchedEnergy.length - _nextPageThresholdEnergy) {
//               fetchEnergy();
//             }
//             if (index == fetchedEnergy.length) {
//               if (_errorEnergy) {
//                 return Center(
//                   child: InkWell(
//                     onTap: () => setState(
//                           () {
//                         _loadingEnergy = true;
//                         _errorEnergy = false;
//                         fetchEnergy();
//                       },
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
//                       child:
//                       Text("Error while loading photos, tap to try again"),
//                     ),
//                   ),
//                 );
//               } else {
//                 return Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8),
//                     child: CircularProgressIndicator(),
//                   ),
//                 );
//               }
//             }
//             final Photo photo = fetchedEnergy[index];
//             return InkWell(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => StoryView(
//                           storyId: photo.newsid.toString(),
//                         )));
//               },
//               child: Card(
//                 margin: const EdgeInsets.symmetric(horizontal: 0.0),
//                 child: Column(
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       height: 250,
//                       decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: NetworkImage(photo.picture),
//                             fit: BoxFit.contain,
//
//                             //   fit: BoxFit.fill,
//                           )),
//                       child: Align(
//                         alignment: Alignment.bottomCenter,
//                         child: Container(
//                           width: MediaQuery.of(context).size.width,
//                           padding: const EdgeInsets.all(20),
//                           decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                   begin: Alignment.topCenter,
//                                   end: Alignment.bottomCenter,
//                                   colors: [
//                                     Colors.transparent.withOpacity(0),
//                                     Colors.black.withOpacity(0.5),
//                                     Colors.black.withOpacity(0.1),
//                                   ])),
//                           child: Text(
//                             photo.title,
//                             style: TextStyle(
//                               // fontWeight: FontWeight.bold,
//                                 fontSize: 22,
//                                 color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.share),
//                           color: Colors.grey,
//                           onPressed: () {
//                             Share.share(
//                                 'check out this news ' +
//                                     fetchedEnergy[index].link,
//                                 subject: fetchedEnergy[index].title);
//                           },
//                         ),
//                         /*IconButton(
//                           icon: Icon(Icons.bookmark_border),
//                           color: Colors.grey,
//                           /*onPressed: () async{
//                             final box = GetStorage();
//                             print(box.read('bookmark'));
//                             List<dynamic> list=box.read('bookmark');
//                             if(list!=null){
//                               list.add(photo);
//                               await box.write('bookmark', list);
//                             }else{
//                               list=[];
//                               list.add(photo);
//                               await box.write('bookmark', list);
//                             }
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => BokkmarksScreen()));
//                           },*/
//                         ),*/
//                       ],
//                     ),
//                     // if (index %5==0)
//                     //   Container(
//                     //     height: _height,
//                     //     padding: EdgeInsets.all(10),
//                     //     margin: EdgeInsets.only(bottom: 20.0),
//                     //     child: NativeAdmob(
//                     //       // Your ad unit id
//                     //       adUnitID: _adUnitID,
//                     //       controller: _nativeAdController,
//
//                     //       // Don't show loading widget when in loading state
//                     //       loading: Container(),
//                     //     ),
//                     //   ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//     }
//     return Container();
//   }
//
//   Widget getHealth() {
//     if (fetchedHealth == null) {
//       if (_loadingHealth) {
//         return Center(
//             child: Padding(
//               padding: const EdgeInsets.all(8),
//               child: CircularProgressIndicator(),
//             ));
//       } else if (_errorHealth) {
//         return Center(
//           child: InkWell(
//             onTap: () => setState(
//                   () {
//                 _loadingHealth = true;
//                 _errorHealth = false;
//                 fetchHealth();
//               },
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Text("Error while loading photos, tap to try agin"),
//             ),
//           ),
//         );
//       }
//     } else {
//       return RefreshIndicator(
//         onRefresh: RefreshHealth,
//         // return null;
//         child: ListView.builder(
//           itemCount: fetchedHealth.length + (_hasMoreHealHealth ? 1 : 0),
//           itemBuilder: (context, index) {
//             if (index == fetchedHealth.length - _nextPageThresholdHealth) {
//               fetchHealth();
//             }
//             if (index == fetchedHealth.length) {
//               if (_errorHealth) {
//                 return Center(
//                   child: InkWell(
//                     onTap: () => setState(
//                           () {
//                         _loadingHealth = true;
//                         _errorHealth = false;
//                         fetchHealth();
//                       },
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
//                       child:
//                       Text("Error while loading photos, tap to try agin"),
//                     ),
//                   ),
//                 );
//               } else {
//                 return Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8),
//                     child: CircularProgressIndicator(),
//                   ),
//                 );
//               }
//             }
//             final Photo photo = fetchedHealth[index];
//             return InkWell(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => StoryView(
//                           storyId: photo.newsid.toString(),
//                         )));
//               },
//               child: Card(
//                 margin: const EdgeInsets.symmetric(horizontal: 0.0),
//                 child: Column(
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       height: 250,
//                       decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: NetworkImage(photo.picture),
//                             fit: BoxFit.contain,
//
//                             //     fit: BoxFit.fill,
//                           )),
//                       child: Align(
//                         alignment: Alignment.bottomCenter,
//                         child: Container(
//                           width: MediaQuery.of(context).size.width,
//                           padding: const EdgeInsets.all(20),
//                           decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                   begin: Alignment.topCenter,
//                                   end: Alignment.bottomCenter,
//                                   colors: [
//                                     Colors.transparent.withOpacity(0),
//                                     Colors.black.withOpacity(0.5),
//                                     Colors.black.withOpacity(0.1),
//                                   ])),
//                           child: Text(
//                             photo.title,
//                             style: TextStyle(
//                               // fontWeight: FontWeight.bold,
//                                 fontSize: 22,
//                                 color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.share),
//                           color: Colors.grey,
//                           onPressed: () {
//                             Share.share(
//                                 'check out this news ' +
//                                     fetchedHealth[index].link,
//                                 subject: fetchedHealth[index].title);
//                           },
//                         ),
//                         /*    IconButton(
//                           icon: Icon(Icons.bookmark_border),
//                           color: Colors.grey,
//                         /*  onPressed: () async{
//                             final box = GetStorage();
//                             print(box.read('bookmark'));
//                             List<dynamic> list=box.read('bookmark');
//                             if(list!=null){
//                               list.add(photo);
//                               await box.write('bookmark', list);
//                             }else{
//                               list=[];
//                               list.add(photo);
//                               await box.write('bookmark', list);
//                             }
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => BokkmarksScreen()));
//                           },*/
//                         ),*/
//                       ],
//                     ),
//                     // if (index %5==0)
//                     //   Container(
//                     //     height: _height,
//                     //     padding: EdgeInsets.all(10),
//                     //     margin: EdgeInsets.only(bottom: 20.0),
//                     //     child: NativeAdmob(
//                     //       // Your ad unit id
//                     //       adUnitID: _adUnitID,
//                     //       controller: _nativeAdController,
//
//                     //       // Don't show loading widget when in loading state
//                     //       loading: Container(),
//                     //     ),
//                     //   ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//     }
//     return Container();
//   }
//
//   Widget getHome() {
//     if (fetchedHome == null) {
//       if (_loadingHome) {
//         return Center(
//             child: Padding(
//               padding: const EdgeInsets.all(8),
//               child: CircularProgressIndicator(),
//             ));
//       } else if (_errorHome) {
//         return Center(
//           child: InkWell(
//             onTap: () => setState(
//                   () {
//                 _loadingHome = true;
//                 _errorHome = false;
//                 fetchHome();
//               },
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Text("Error while loading photos, tap to try agin"),
//             ),
//           ),
//         );
//       }
//     } else {
//       return RefreshIndicator(
//         onRefresh: RefreshHome,
//         // return null;
//         child: ListView.builder(
//           itemCount: fetchedHome.length + (_hasMoreHome ? 1 : 0),
//           itemBuilder: (context, index) {
//             if (index == fetchedHome.length - _nextPageThresholdHome) {
//               fetchHome();
//             }
//             if (index == fetchedHome.length) {
//               if (_errorHome) {
//                 return Center(
//                   child: InkWell(
//                     onTap: () => setState(
//                           () {
//                         _loadingHome = true;
//                         _errorHome = false;
//                         fetchHome();
//                       },
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
//                       child:
//                       Text("Error while loading photos, tap to try agin"),
//                     ),
//                   ),
//                 );
//               } else {
//                 return Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8),
//                     child: CircularProgressIndicator(),
//                   ),
//                 );
//               }
//             }
//             final Photo photo = fetchedHome[index];
//             return Card(
//               margin: const EdgeInsets.symmetric(horizontal: 0.0),
//               child: Column(
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => StoryView(
//                                 storyId: photo.newsid.toString(),
//                               )));
//                     },
//                     child: Container(
//                       width: MediaQuery.of(context).size.width,
//                       height: 220,
//                       decoration: BoxDecoration(
//                         // border: Border.all(width: 0, style: BorderStyle.none),
//                         //borderRadius: BorderRadius.circular(0.0),
//                           image: DecorationImage(
//                             image: NetworkImage(
//                               photo.picture,
//                             ),
//                             fit: BoxFit.contain,
//
//                             // fit: BoxFit.fill,
//                           )),
//                       child: Align(
//                         alignment: Alignment.bottomCenter,
//                         child: Container(
//                           width: MediaQuery.of(context).size.width,
//                           padding: const EdgeInsets.all(20),
//                           decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                   begin: Alignment.topCenter,
//                                   end: Alignment.bottomCenter,
//                                   colors: [
//                                     Colors.transparent.withOpacity(0),
//                                     Colors.black.withOpacity(0.5),
//                                     Colors.black.withOpacity(1)
//                                   ])),
//                           child: Text(
//                             photo.title,
//                             style: TextStyle(
//                               // fontWeight: FontWeight.bold,
//                                 fontSize: 22,
//                                 color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       IconButton(
//                           icon: Icon(Icons.save_alt_sharp),
//                           color: Colors.grey,
//                           onPressed: () {
//                             // Navigator.push(
//                             //            context,
//                             //             MaterialPageRoute(
//                             //       builder: (context) => StoryView(
//                             //       storyId: fetchedHome[index].newsid.toString(),
//                             //        )));
//                             setState(() {
//                               insertArt(
//                                   fetchedHome[index].newsid,
//                                   fetchedHome[index].picture.toString(),
//                                   fetchedHome[index].title.toString());
//                             },
//                             );
//                           }
//
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.share),
//                         color: Colors.grey,
//                         onPressed: () {
//                           Share.share(
//                               'check out this news ' +
//                                   fetchedHome[index].link,
//                               subject: fetchedHome[index].title);
//                         },
//                       ),
//
//                       /* IconButton(
//                         icon: Icon(Icons.bookmark_border),
//                         color: Colors.grey,
//                        /* onPressed: () async{
//                           final box = GetStorage();
//                           print(box.read('bookmark'));
//                           List<dynamic> list=box.read('bookmark');
//                           if(list!=null){
//                             list.add(photo);
//                             await box.write('bookmark', list);
//                           }else{
//                             list=[];
//                             list.add(photo);
//                             await box.write('bookmark', list);
//                           }
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => BokkmarksScreen()));
//                         },*/
//                       ),*/
//                     ],
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   if (index % 5 == 0)
//                     Container(
//                         height: _height,
//                         padding: EdgeInsets.all(10),
//                         margin: EdgeInsets.only(bottom: 20.0),
//                         child: Text("test ads 1")
//                       // NativeAdmob(
//                       //   // Your ad unit id
//                       //   adUnitID: _adUnitID,
//                       //   controller: _nativeAdController,
//                       //   numberAds: 1,
//
//                       //   // Don't show loading widget when in loading state
//                       //   loading: Container(),
//                       // ),
//                     ),
//                 ],
//               ),
//             );
//           },
//         ),
//       );
//     }
//     return Container();
//   }
//
//   Widget getEntertainment() {
//     if (fetchedEntertainment == null) {
//       if (_loadingEntertainment) {
//         return Center(
//             child: Padding(
//               padding: const EdgeInsets.all(8),
//               child: CircularProgressIndicator(),
//             ));
//       } else if (_errorEntertainment) {
//         return Center(
//           child: InkWell(
//             onTap: () => setState(
//                   () {
//                 _loadingEntertainment = true;
//                 _errorEntertainment = false;
//                 fetchEntertainment();
//               },
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Text("Error while loading photos, tap to try agin"),
//             ),
//           ),
//         );
//       }
//     } else {
//       return RefreshIndicator(
//         onRefresh: RefreshEntertainment,
//         // return null;
//         child: ListView.builder(
//           itemCount:
//           fetchedEntertainment.length + (_hasMoreEntertainment ? 1 : 0),
//           itemBuilder: (context, index) {
//             if (index ==
//                 fetchedEntertainment.length - _nextPageThresholdEntertainment) {
//               fetchEntertainment();
//             }
//             if (index == fetchedEntertainment.length) {
//               if (_errorEntertainment) {
//                 return Center(
//                   child: InkWell(
//                     onTap: () => setState(
//                           () {
//                         _loadingEntertainment = true;
//                         _errorEntertainment = false;
//                         fetchEntertainment();
//                       },
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
//                       child:
//                       Text("Error while loading photos, tap to try agin"),
//                     ),
//                   ),
//                 );
//               } else {
//                 return Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8),
//                     child: CircularProgressIndicator(),
//                   ),
//                 );
//               }
//             }
//             final Photo photo = fetchedEntertainment[index];
//             return InkWell(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => StoryView(
//                           storyId: photo.newsid.toString(),
//                         )));
//               },
//               child: Card(
//                 margin: const EdgeInsets.symmetric(horizontal: 0.0),
//                 child: Column(
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       height: 250,
//                       decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: NetworkImage(photo.picture),
//                             fit: BoxFit.contain,
//
//                             // fit: BoxFit.fill,
//                           )),
//                       child: Align(
//                         alignment: Alignment.bottomCenter,
//                         child: Container(
//                           width: MediaQuery.of(context).size.width,
//                           padding: const EdgeInsets.all(20),
//                           decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                   begin: Alignment.topCenter,
//                                   end: Alignment.bottomCenter,
//                                   colors: [
//                                     Colors.transparent.withOpacity(0),
//                                     Colors.black.withOpacity(0.5),
//                                     Colors.black.withOpacity(1)
//                                   ])),
//                           child: Text(
//                             photo.title,
//                             style: TextStyle(
//                               // fontWeight: FontWeight.bold,
//                                 fontSize: 22,
//                                 color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.share),
//                           color: Colors.grey,
//                           onPressed: () {
//                             Share.share(
//                                 'check out this news ' +
//                                     fetchedEntertainment[index].link,
//                                 subject: fetchedEntertainment[index].title);
//                           },
//                         ),
//                         /*   IconButton(
//                           icon: Icon(Icons.bookmark_border),
//                           color: Colors.grey,
//                           /*onPressed: () async{
//                             final box = GetStorage();
//                             print(box.read('bookmark'));
//                             List<dynamic> list=box.read('bookmark');
//                             if(list!=null){
//                               list.add(photo);
//                               await box.write('bookmark', list);
//                             }else{
//                               list=[];
//                               list.add(photo);
//                               await box.write('bookmark', list);
//                             }
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => BokkmarksScreen()));
//                           },*/
//                         ),*/
//                       ],
//                     ),
//                     // if (index %5==0)
//                     //   Container(
//                     //     height: _height,
//                     //     padding: EdgeInsets.all(10),
//                     //     margin: EdgeInsets.only(bottom: 20.0),
//                     //     child: NativeAdmob(
//                     //       // Your ad unit id
//                     //       adUnitID: _adUnitID,
//                     //       controller: _nativeAdController,
//
//                     //       // Don't show loading widget when in loading state
//                     //       loading: Container(),
//                     //     ),
//                     //   ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//     }
//     return Container();
//   }
//
//   Widget getSports() {
//     if (fetchedSports == null) {
//       if (!_loadingSports && !_errorSports) {
//         setState(() {
//           _loadingSports = true;
//         });
//
//         fetchSports();
//       } else if (_loadingSports) {
//         return Center(
//             child: Padding(
//               padding: const EdgeInsets.all(8),
//               child: CircularProgressIndicator(),
//             ));
//       } else if (_errorSports) {
//         return Center(
//           child: InkWell(
//             onTap: () => setState(
//                   () {
//                 _loadingSports = true;
//                 _errorSports = false;
//                 fetchSports();
//               },
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Text("Error while loading photos, tap to try agin"),
//             ),
//           ),
//         );
//       }
//     } else {
//       return RefreshIndicator(
//         onRefresh: RefreshSports,
//         // return null;
//         child: ListView.builder(
//           itemCount: fetchedSports.length + (_hasMoreSports ? 1 : 0),
//           itemBuilder: (context, index) {
//             if (index == fetchedSports.length - _nextPageThresholdSports) {
//               fetchSports();
//             }
//             if (index == fetchedSports.length) {
//               if (_errorSports) {
//                 return Center(
//                   child: InkWell(
//                     onTap: () => setState(
//                           () {
//                         _loadingSports = true;
//                         _errorSports = false;
//                         fetchSports();
//                       },
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
//                       child:
//                       Text("Error while loading photos, tap to try agin"),
//                     ),
//                   ),
//                 );
//               } else {
//                 return Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8),
//                     child: CircularProgressIndicator(),
//                   ),
//                 );
//               }
//             }
//             final Photo photo = fetchedSports[index];
//             return InkWell(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => StoryView(
//                           storyId: photo.newsid.toString(),
//                         )));
//               },
//               child: Card(
//                 margin: const EdgeInsets.symmetric(horizontal: 0.0),
//                 child: Column(
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       height: 250,
//                       decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: NetworkImage(photo.picture),
//                             fit: BoxFit.contain,
//
//                             //   fit: BoxFit.fill,
//                           )),
//                       child: Align(
//                         alignment: Alignment.bottomCenter,
//                         child: Container(
//                           width: MediaQuery.of(context).size.width,
//                           padding: const EdgeInsets.all(20),
//                           decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                   begin: Alignment.topCenter,
//                                   end: Alignment.bottomCenter,
//                                   colors: [
//                                     Colors.transparent.withOpacity(0),
//                                     Colors.black.withOpacity(0.5),
//                                     Colors.black.withOpacity(1)
//                                   ])),
//                           child: Text(
//                             photo.title,
//                             style: TextStyle(
//                               // fontWeight: FontWeight.bold,
//                                 fontSize: 22,
//                                 color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.share),
//                           color: Colors.grey,
//                           onPressed: () {
//                             Share.share(
//                                 'check out this news ' +
//                                     fetchedSports[index].link,
//                                 subject: fetchedSports[index].title);
//                           },
//                         ),
//                         /* IconButton(
//                           icon: Icon(Icons.bookmark_border),
//                           color: Colors.grey,
//                          /* onPressed: () async{
//                             final box = GetStorage();
//                             print(box.read('bookmark'));
//                             List<dynamic> list=box.read('bookmark');
//                             if(list!=null){
//                               list.add(photo);
//                               await box.write('bookmark', list);
//                             }else{
//                               list=[];
//                               list.add(photo);
//                               await box.write('bookmark', list);
//                             }
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => BokkmarksScreen()));
//                           },*/
//                         ),*/
//                       ],
//                     ),
//                     // if (index %5==0)
//                     //   Container(
//                     //     height: _height,
//                     //     padding: EdgeInsets.all(10),
//                     //     margin: EdgeInsets.only(bottom: 20.0),
//                     //     child: NativeAdmob(
//                     //       // Your ad unit id
//                     //       adUnitID: _adUnitID,
//                     //       controller: _nativeAdController,
//
//                     //       // Don't show loading widget when in loading state
//                     //       loading: Container(),
//                     //     ),
//                     //   ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//     }
//     return Container();
//   }
//
//   Widget getCrypto() {
//     if (fetchedCrypto == null) {
//       if (_loadingCrypto) {
//         return Center(
//             child: Padding(
//               padding: const EdgeInsets.all(8),
//               child: CircularProgressIndicator(),
//             ));
//       } else if (_errorCrypto) {
//         return Center(
//           child: InkWell(
//             onTap: () => setState(
//                   () {
//                 _loadingCrypto = true;
//                 _errorCrypto = false;
//                 fetchCrypto();
//               },
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Text("Error while loading photos, tap to try agin"),
//             ),
//           ),
//         );
//       }
//     } else {
//       return RefreshIndicator(
//         onRefresh: RefreshCrypto,
//         // return null;
//         child: ListView.builder(
//           itemCount: fetchedCrypto.length + (_hasMoreCrypto ? 1 : 0),
//           itemBuilder: (context, index) {
//             if (index == fetchedCrypto.length - _nextPageThresholdCrypto) {
//               fetchCrypto();
//             }
//             if (index == fetchedCrypto.length) {
//               if (_errorCrypto) {
//                 return Center(
//                   child: InkWell(
//                     onTap: () => setState(
//                           () {
//                         _loadingCrypto = true;
//                         _errorCrypto = false;
//                         fetchCrypto();
//                       },
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
//                       child:
//                       Text("Error while loading photos, tap to try again"),
//                     ),
//                   ),
//                 );
//               } else {
//                 return Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8),
//                     child: CircularProgressIndicator(),
//                   ),
//                 );
//               }
//             }
//             final Photo photo = fetchedCrypto[index];
//             return InkWell(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => StoryView(
//                           storyId: photo.newsid.toString(),
//                         )));
//               },
//               child: Card(
//                 margin: const EdgeInsets.symmetric(horizontal: 0.0),
//                 child: Column(
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       height: 250,
//                       decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: NetworkImage(photo.picture),
//                             fit: BoxFit.contain,
//
//                             //   fit: BoxFit.fill,
//                           )),
//                       child: Align(
//                         alignment: Alignment.bottomCenter,
//                         child: Container(
//                           width: MediaQuery.of(context).size.width,
//                           padding: const EdgeInsets.all(20),
//                           decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                   begin: Alignment.topCenter,
//                                   end: Alignment.bottomCenter,
//                                   colors: [
//                                     Colors.transparent.withOpacity(0),
//                                     Colors.black.withOpacity(0.5),
//                                     Colors.black.withOpacity(1),
//                                   ])),
//                           child: Text(
//                             photo.title,
//                             style: TextStyle(
//                               // fontWeight: FontWeight.bold,
//                                 fontSize: 22,
//                                 color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.share),
//                           color: Colors.grey,
//                           onPressed: () {
//                             Share.share(
//                                 'check out this news ' +
//                                     fetchedCrypto[index].link,
//                                 subject: fetchedCrypto[index].title);
//                           },
//                         ),
//                         /*    IconButton(
//                           icon: Icon(Icons.bookmark_border),
//                           color: Colors.grey,
//                         /*  onPressed: () async{
//                             final box = GetStorage();
//                             print(box.read('bookmark'));
//                             List<dynamic> list=box.read('bookmark');
//                             if(list!=null){
//                               list.add(photo);
//                               await box.write('bookmark', list);
//                             }else{
//                               list=[];
//                               list.add(photo);
//                               await box.write('bookmark', list);
//                             }
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => BokkmarksScreen()));
//                           },*/
//                         ),*/
//                       ],
//                     ),
//                     // if (index %5==0)
//                     //   Container(
//                     //     height: _height,
//                     //     padding: EdgeInsets.all(10),
//                     //     margin: EdgeInsets.only(bottom: 20.0),
//                     //     child: NativeAdmob(
//                     //       // Your ad unit id
//                     //       adUnitID: _adUnitID,
//                     //       controller: _nativeAdController,
//
//                     //       // Don't show loading widget when in loading state
//                     //       loading: Container(),
//                     //     ),
//                     //   ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//     }
//     return Container();
//   }
//
//   Widget getPolitics() {
//     if (fetchedPolitics == null) {
//       if (_loadingPolitics) {
//         return Center(
//             child: Padding(
//               padding: const EdgeInsets.all(8),
//               child: CircularProgressIndicator(),
//             ));
//       } else if (_errorPolitics) {
//         return Center(
//           child: InkWell(
//             onTap: () => setState(
//                   () {
//                 _loadingPolitics = true;
//                 _errorPolitics = false;
//                 fetchPolitics();
//               },
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Text("Error while loading photos, tap to try agin"),
//             ),
//           ),
//         );
//       }
//     } else {
//       return RefreshIndicator(
//         onRefresh: RefreshPolitics,
//         // return null;
//         child: ListView.builder(
//           itemCount: fetchedPolitics.length + (_hasMorePolitics ? 1 : 0),
//           itemBuilder: (context, index) {
//             if (index == fetchedPolitics.length - _nextPageThresholdPolitics) {
//               fetchPolitics();
//             }
//             if (index == fetchedPolitics.length) {
//               if (_errorPolitics) {
//                 return Center(
//                   child: InkWell(
//                     onTap: () => setState(
//                           () {
//                         _loadingPolitics = true;
//                         _errorPolitics = false;
//                         fetchPolitics();
//                       },
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
//                       child:
//                       Text("Error while loading photos, tap to try agin"),
//                     ),
//                   ),
//                 );
//               } else {
//                 return Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8),
//                     child: CircularProgressIndicator(),
//                   ),
//                 );
//               }
//             }
//             final Photo photo = fetchedPolitics[index];
//             return Column(
//               children: [
//                 InkWell(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => StoryView(
//                                 storyId: photo.newsid.toString(),
//                               )));
//                     },
//                     child: Padding(
//                       padding:
//                       EdgeInsets.symmetric(horizontal: 0, vertical: 12),
//                       child: Card(
//                         margin: const EdgeInsets.symmetric(horizontal: 0.0),
//                         child: Column(
//                           children: [
//                             Container(
//                               width: MediaQuery.of(context).size.width,
//                               //  width: double.infinity,
//                               height: 250,
//                               decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                     image: NetworkImage(photo.picture),
//                                     fit: BoxFit.contain,
//
//                                     //  fit: BoxFit.fill,
//                                   )),
//                               child: Align(
//                                 alignment: Alignment.bottomCenter,
//                                 child: Container(
//                                   width: MediaQuery.of(context).size.width,
//                                   padding: const EdgeInsets.all(20),
//                                   decoration: BoxDecoration(
//                                       gradient: LinearGradient(
//                                           begin: Alignment.topCenter,
//                                           end: Alignment.bottomCenter,
//                                           colors: [
//                                             Colors.transparent.withOpacity(0),
//                                             Colors.black.withOpacity(0.5),
//                                             Colors.black.withOpacity(1)
//                                           ])),
//                                   child: Text(
//                                     photo.title,
//                                     style: TextStyle(
//                                       // fontWeight: FontWeight.bold,
//                                         fontSize: 22,
//                                         color: Colors.white),
//                                   ),
//                                 ),
//                               ),
//                             ),
//
//
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 IconButton(
//                                   icon: Icon(Icons.share),
//                                   color: Colors.grey,
//                                   onPressed: () {
//                                     Share.share(
//                                         'check out this news ' +
//                                             fetchedPolitics[index].link,
//                                         subject: fetchedPolitics[index].title);
//                                   },
//                                 ),
//                                 /*    IconButton(
//                           icon: Icon(Icons.bookmark_border),
//                           color: Colors.grey,
//                         /*  onPressed: () async{
//                             final box = GetStorage();
//                             print(box.read('bookmark'));
//                             List<dynamic> list=box.read('bookmark');
//                             if(list!=null){
//                               list.add(photo);
//                               await box.write('bookmark', list);
//                             }else{
//                               list=[];
//                               list.add(photo);
//                               await box.write('bookmark', list);
//                             }
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => BokkmarksScreen()));
//                           },*/
//                         ),*/
//                               ],
//                             ),
//                             // if (index %5==0)
//                             //  Container(
//                             //     //height: _height,
//                             //     height: 250,
//                             //     padding: EdgeInsets.all(10),
//                             //     margin: EdgeInsets.only(bottom: 10.0),
//                             //     child:
//                             //     //Text("test ads")
//                             //    _nativeAdContainer()
//                             //   //  _bannerAd()
//                             //     // NativeAdmob(
//                             //     //   // Your ad unit id
//                             //     //   adUnitID: _adUnitID,
//                             //     //   controller: _nativeAdController,
//
//                             //     //   // Don't show loading widget when in loading state
//                             //     //   loading: Container(),
//                             //     // ),
//                             //   ),
//                           ],
//                         ),
//                       ),
//                     )),
//                 if (index % 5 == 0)
//                   Container(
//                     //height: _height,
//                       height: 250,
//                       padding: EdgeInsets.all(10),
//                       margin: EdgeInsets.only(bottom: 10.0),
//                       child:
//                       //Text("test ads")
//                       _nativeAdContainer()
//                     //  _bannerAd()
//                     // NativeAdmob(
//                     //   // Your ad unit id
//                     //   adUnitID: _adUnitID,
//                     //   controller: _nativeAdController,
//
//                     //   // Don't show loading widget when in loading state
//                     //   loading: Container(),
//                     // ),
//                   ),
//               ],
//             );
//           },
//         ),
//       );
//     }
//     return Container();
//   }
//
//   Widget _bannerAd() {
//     return AdmobBanner(
//       adUnitId: AdsManager.bannerAdUnitId,
//       adSize: AdmobBannerSize.BANNER,
//     );
//   }
//
//   Widget _nativeAdContainer() {
//     return Container(
//       margin: EdgeInsets.all(30),
//       height: 200,
//       child: NativeAdmob(
//         adUnitID: AdsManager.nativeAdUnitId,
//         //AdsManager.nativeAdUnitId,
//         numberAds: 1,
//         controller: _nativeAdController,
//         type: NativeAdmobType.full,
//       ),
//     );
//   }
//
//   bool _hasMoreSports;
//   int _pageNumberSports;
//   bool _errorSports;
//   bool _loadingSports;
//   final int _defaultPhotosPerPageCountSports = 10;
//   final int _nextPageThresholdSports = 5;
//
//   bool _hasMorePolitics;
//   int _pageNumberPolitics;
//   bool _errorPolitics;
//   bool _loadingPolitics;
//   final int _defaultPhotosPerPageCountPolitics = 10;
//   final int _nextPageThresholdPolitics = 5;
//
//   bool _hasMoreCrypto;
//   int _pageNumberCrypto;
//   bool _errorCrypto;
//   bool _loadingCrypto;
//   final int _defaultPhotosPerPageCountCrypto = 10;
//   final int _nextPageThresholdCrypto = 5;
//
//   bool _hasMoreEntertainment;
//   int _pageNumberEntertainment;
//   bool _errorEntertainment;
//   bool _loadingEntertainment;
//   final int _defaultPhotosPerPageCountEntertainment = 10;
//   final int _nextPageThresholdEntertainment = 5;
//
//   bool _hasMoreHome;
//   int _pageNumberHome;
//   bool _errorHome;
//   bool _loadingHome;
//   final int _defaultPhotosPerPageCountHome = 10;
//   final int _nextPageThresholdHome = 5;
//
//   bool _hasMoreHealHealth;
//   int _pageNumberHealth;
//   bool _errorHealth;
//   bool _loadingHealth;
//   final int _defaultPhotosPerPageCountHealth = 10;
//   final int _nextPageThresholdHealth = 5;
//
//   bool _hasMoreEnergy;
//   int _pageNumberEnergy;
//   bool _errorEnergy;
//   bool _loadingEnergy;
//   final int _defaultPhotosPerPageCountEnergy = 10;
//   final int _nextPageThresholdEnergy = 5;
//
//   bool _hasMoreTelecom;
//   int _pageNumberTelecom;
//   bool _errorTelecom;
//   bool _loadingTelecom;
//   final int _defaultPhotosPerPageCountTelecom = 10;
//   final int _nextPageThresholdTelecom = 5;
//
//   Future<Null> RefreshPolitics() async {
//     await fetchPolitics();
//     return null;
//   }
//
//   Future<Null> RefreshCrypto() async {
//     await fetchCrypto();
//     return null;
//   }
//
//   Future<Null> RefreshSports() async {
//     await fetchSports();
//     return null;
//   }
//
//   Future<Null> RefreshEntertainment() async {
//     await fetchEntertainment();
//     return null;
//   }
//
//   Future<Null> RefreshHome() async {
//     await fetchHome();
//     return null;
//   }
//
//   Future<Null> RefreshHealth() async {
//     await fetchHealth();
//     return null;
//   }
//
//   Future<Null> RefreshEnergy() async {
//     await fetchEnergy();
//     return null;
//   }
//
//   Future<Null> RefreshTelecom() async {
//     await fetchTelecom();
//     return null;
//   }
//
//   Future<void> StartData() {
//     _hasMorePolitics = true;
//     _pageNumberPolitics = 1;
//     _errorPolitics = false;
//     _loadingPolitics = true;
//
//     _hasMoreSports = true;
//     _pageNumberSports = 1;
//     _errorSports = false;
//     _loadingSports = false;
//
//     _hasMoreCrypto = true;
//     _pageNumberCrypto = 1;
//     _errorCrypto = false;
//     _loadingCrypto = true;
//
//     _hasMoreEntertainment = true;
//     _pageNumberEntertainment = 1;
//     _errorEntertainment = false;
//     _loadingEntertainment = true;
//
//     _hasMoreHome = true;
//     _pageNumberHome = 1;
//     _errorHome = false;
//     _loadingHome = true;
//
//     _hasMoreHealHealth = true;
//     _pageNumberHealth = 1;
//     _errorHealth = false;
//     _loadingHealth = true;
//
//     _hasMoreEnergy = true;
//     _pageNumberEnergy = 1;
//     _errorEnergy = false;
//     _loadingEnergy = true;
//
//     _hasMoreTelecom = true;
//     _pageNumberTelecom = 1;
//     _errorTelecom = false;
//     _loadingTelecom = true;
//
//     fetchHome();
//     fetchPolitics();
//     fetchCrypto();
//     fetchEnergy();
//     fetchEntertainment();
//     fetchHealth();
//     fetchSports();
//     fetchTelecom();
//
//     // createReawrdAdAndLoad();
//     // RewardedVideoAd.instance.show();
//     // _subscription = _nativeAdController.stateChanged.listen(_onStateChanged);
//     // _nativeAdController.setNonPersonalizedAds(false);
//     // _nativeAdController.reloadAd(forceRefresh: true);
//   }
//
//   void dispose() {
//     // _subscription.cancel();
//     // _nativeAdController.dispose();
//     interstitialAd.dispose();
//     _nativeAdController.dispose();
//     super.dispose();
//   }
//   // void _onStateChanged(AdLoadState state) {
//   // switch (state) {
//   //   case AdLoadState.loading:
//   //     setState(() {
//   //       _height = 0;
//   //     });
//   //     break;
//
//   //   case AdLoadState.loadCompleted:
//   //     setState(() {
//   //       _height = 330;
//   //     });
//   //     break;
//
//   //   default:
//   //     break;
//   // }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: DefaultTabController(
//           initialIndex: 0,
//           length: 8,
//           child: Column(
//             children: <Widget>[
//               Container(
//                 constraints: BoxConstraints.expand(height: 50),
//                 child: TabBar(
//                   indicatorColor:Color(0xff88db52),
//                   isScrollable: true,
//                   labelColor: Colors.black,
//                   unselectedLabelColor: Colors.black,
//                   tabs: [
//                     Tab(
//                       text: 'Home',
//                     ),
//                     Tab(
//                       text: 'Politics',
//                     ),
//                     Tab(
//                       text: 'Crypto',
//                     ),
//                     Tab(
//                       text: 'Entertainment',
//                     ),
//                     Tab(
//                       text: 'Energy',
//                     ),
//                     Tab(
//                       text: 'Health',
//                     ),
//                     Tab(
//                       text: 'Sports',
//                     ),
//                     Tab(
//                       text: 'Telecom',
//                     ),
//                   ],
//                   labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
//                   indicatorWeight: 5,
//                   indicatorSize: TabBarIndicatorSize.tab,
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   child: TabBarView(children: [
//                     getHome(),
//                     getPolitics(),
//                     getCrypto(),
//                     getEntertainment(),
//                     getEnergy(),
//                     getHealth(),
//                     getSports(),
//                     getTelecom(),
//                   ]),
//                 ),
//               ),
//               Container(
//                 //height: _height,
//                   height: 55,
//                   padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//                   // margin: EdgeInsets.only(bottom: 20.0),
//                   child:
//                   //Text("test ads")
//                   // _nativeAdContainer()
//                   _bannerAd()
//                 // NativeAdmob(
//                 //   // Your ad unit id
//                 //   adUnitID: _adUnitID,
//                 //   controller: _nativeAdController,
//
//                 //   // Don't show loading widget when in loading state
//                 //   loading: Container(),
//                 // ),
//               ),
//             ],
//           ),
//         ));
//   }
//
// //Fetch Politics
//   Future<void> fetchPolitics() async {
//     try {
//       final response = await http.get(Uri.parse(
//           "https://menafn.com/mobile/WebAPI/getnews/getsection/MobileEN_Politics-$_pageNumberPolitics"));
//       fetchedPolitics.addAll(Photo.parseList(json.decode(response.body)));
//       setState(
//             () {
//           _hasMorePolitics =
//               fetchedPolitics.length == _defaultPhotosPerPageCountPolitics;
//           _loadingPolitics = false;
//           _pageNumberPolitics = _pageNumberPolitics + 1;
//         },
//       );
//     } catch (e) {
//       setState(
//             () {
//           _loadingPolitics = false;
//           _errorPolitics = true;
//         },
//       );
//     }
//   }
//
// //Fetch Crypto
//   Future<void> fetchCrypto() async {
//     try {
//       final response = await http.get(Uri.parse(
//           "https://menafn.com/mobile/WebAPI/getnews/getsection/MobileEN_Crypto-$_pageNumberCrypto"));
//       fetchedCrypto.addAll(Photo.parseList(json.decode(response.body)));
//       setState(
//             () {
//           _hasMoreCrypto =
//               fetchedCrypto.length == _defaultPhotosPerPageCountCrypto;
//           _loadingCrypto = false;
//           _pageNumberCrypto = _pageNumberCrypto + 1;
//         },
//       );
//     } catch (e) {
//       setState(
//             () {
//           _loadingCrypto = false;
//           _errorCrypto = true;
//         },
//       );
//     }
//   }
//
// //Fetch Sports
//   Future<void> fetchSports() async {
//     try {
//       final response = await http.get(Uri.parse(
//           "https://menafn.com/mobile/WebAPI/getnews/getsection/MobileEN_Sports-$_pageNumberSports"));
//       fetchedSports.addAll(Photo.parseList(json.decode(response.body)));
//       setState(
//             () {
//           _hasMoreSports =
//               fetchedSports.length == _defaultPhotosPerPageCountSports;
//           _loadingSports = false;
//           _pageNumberSports = _pageNumberSports + 1;
//         },
//       );
//     } catch (e) {
//       setState(
//             () {
//           _loadingSports = false;
//           _errorSports = true;
//         },
//       );
//     }
//   }
//
//   //Fetch Entertainment
//   Future<void> fetchEntertainment() async {
//     try {
//       final response = await http.get(Uri.parse(
//           "https://menafn.com/mobile/WebAPI/getnews/getsection/MobileEN_Entertainment-$_pageNumberEntertainment"));
//       fetchedEntertainment.addAll(Photo.parseList(json.decode(response.body)));
//       setState(
//             () {
//           _hasMoreEntertainment = fetchedEntertainment.length ==
//               _defaultPhotosPerPageCountEntertainment;
//           _loadingEntertainment = false;
//           _pageNumberEntertainment = _pageNumberEntertainment + 1;
//         },
//       );
//     } catch (e) {
//       setState(
//             () {
//           _loadingEntertainment = false;
//           _errorEntertainment = true;
//         },
//       );
//     }
//   }
//
//   //Fetch Home
//   Future<void> fetchHome() async {
//     try {
//       final response = await http.get(Uri.parse(
//           "https://menafn.com/mobile/WebAPI/getnews/getsection/MobileEN_Home-$_pageNumberHome"));
//       fetchedHome.addAll(Photo.parseList(json.decode(response.body)));
//       setState(
//             () {
//           _hasMoreHome = fetchedHome.length == _defaultPhotosPerPageCountHome;
//           _loadingHome = false;
//           _pageNumberHome = _pageNumberHome + 1;
//         },
//       );
//     } catch (e) {
//       setState(
//             () {
//           _loadingHome = false;
//           _errorHome = true;
//         },
//       );
//     }
//   }
//
//   //Fetch Health
//   Future<void> fetchHealth() async {
//     try {
//       final response = await http.get(Uri.parse(
//           "https://menafn.com/mobile/WebAPI/getnews/getsection/MobileEN_Health-$_pageNumberHealth"));
//       fetchedHealth.addAll(Photo.parseList(json.decode(response.body)));
//       setState(
//             () {
//           _hasMoreHealHealth =
//               fetchedHealth.length == _defaultPhotosPerPageCountHealth;
//           _loadingHealth = false;
//           _pageNumberHealth = _pageNumberHealth + 1;
//         },
//       );
//     } catch (e) {
//       setState(
//             () {
//           _loadingHealth = false;
//           _errorHealth = true;
//         },
//       );
//     }
//   }
//
//   //Fetch Energy
//   Future<void> fetchEnergy() async {
//     try {
//       final response = await http.get(Uri.parse(
//           "https://menafn.com/mobile/WebAPI/getnews/getsection/MobileEN_Energy-$_pageNumberEnergy"));
//       fetchedEnergy.addAll(Photo.parseList(json.decode(response.body)));
//       setState(
//             () {
//           _hasMoreEnergy =
//               fetchedEnergy.length == _defaultPhotosPerPageCountEnergy;
//           _loadingEnergy = false;
//           _pageNumberEnergy = _pageNumberEnergy + 1;
//         },
//       );
//     } catch (e) {
//       setState(
//             () {
//           _loadingEnergy = false;
//           _errorEnergy = true;
//         },
//       );
//     }
//   }
//
//
//   void initDb() async {
//     database =await openDatabase('saveart.db',
//         version: 1,
//         onCreate: (database,version) {
//           print("database created");
//           database.execute(
//               'CREATE TABLE saveArt (id INTEGER PRIMARY KEY, newsId INTEGER, imagePath Text, newsTitle Text)')
//               .then((value) {
//             print('table create');
//           }).catchError((error) {
//             print('Error when  creating table');
//           });
//
//         },
//         onOpen: (database){
//
//           getDataFromDatabase(database).then((value) {
//             setState(() {
//               tasks = value;
//
//               print('tasks12$tasks');
//               //print(tasks);
//             });
//
//
//
//           });
//           print('database opened ');
//
//         });
//
//
//   }
//
//   Future<void> insertArt(int newsId, String imagePath, String newsTitle) async {
//
//     await database.transaction((txn) async {
//       await txn.rawInsert(
//           'INSERT INTO saveArt(newsId, imagePath, newsTitle) VALUES(?, ?, ?)',
//           [newsId, imagePath, newsTitle]).then((value){print('insert row done $newsId');
//       getDataFromDatabase(database);
//       }).catchError((error){print('not insert $error');});
//
//     });
//
//
//
//   }
//   Future<dynamic> getDataFromDatabase(database)async
//   {
//
//     return await database.rawQuery('SELECT * FROM saveArt ORDER BY id DESC');
//
//   }
//
//
//   //Fetch Telecom
//   Future<void> fetchTelecom() async {
//     try {
//       final response = await http.get(Uri.parse(
//           "https://menafn.com/mobile/WebAPI/getnews/getsection/MobileEN_Telecom-$_pageNumberTelecom"));
//       fetchedTelecom.addAll(Photo.parseList(json.decode(response.body)));
//       setState(
//             () {
//           _hasMoreTelecom =
//               fetchedTelecom.length == _defaultPhotosPerPageCountTelecom;
//           _loadingTelecom = false;
//           _pageNumberTelecom = _pageNumberTelecom + 1;
//         },
//       );
//     } catch (e) {
//       setState(
//             () {
//           _loadingTelecom = false;
//           _errorTelecom = true;
//         },
//       );
//     }
//   }
// }
//
// class Photo {
//   final int newsid;
//   final String newsdate;
//   final String title;
//   final String picture;
//   final String company;
//   final String link;
//
//   Photo(this.newsid, this.newsdate, this.title, this.picture, this.company,
//       this.link);
//
//   factory Photo.fromJson(Map<String, dynamic> json) {
//     return Photo(json["newsid"], json["newsdate"], json["title"],
//         json["picture"], json["company"], json["link"]);
//   }
//
//   static List<Photo> parseList(List<dynamic> list) {
//     return list.map((i) => Photo.fromJson(i)).toList();
//   }
//
//   String toJson() => json.encode(toMap());
//
//   Map<String, dynamic> toMap() => {
//     "newsid": newsid == null ? null : newsid,
//     "newsdate": newsdate == null ? null : newsdate,
//     "title": title == null ? null : title,
//     "picture": picture == null ? null : picture,
//     "company": company == null ? null : company,
//     "link": link == null ? null : link,
//   };
// }
//
