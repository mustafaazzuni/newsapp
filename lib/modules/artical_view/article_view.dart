import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:menafn/layout/news_app/cubit/cubit.dart';
import 'package:menafn/layout/news_app/cubit/states.dart';
import 'package:menafn/shared/adsManager.dart';

import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatelessWidget {
  final String postUrl;
  ArticleView({@required this.postUrl});

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //  centerTitle: true, // this is all you need
        // title: Row(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   mainAxisSize: MainAxisSize.min,
        //   children: <Widget>[
        //     Image.asset(
        //       'images/menafn_logo.png',
        //       height: 31,
        //
        //       alignment: Alignment.center,
        //     )
        //
        //   ],
        // ),
        actions: [
          //   IconButton(
          //
          //
          //   icon: Icon(Icons.save_alt_sharp),
          //   color: Colors.grey,
          //   //  onPressed: () {
          //   //  Navigator.push(
          //   //    context
          //   //  MaterialPageRoute(
          //   //    builder: (context) => StoryView(
          //   //    storyId: fetchedHome[index].newsid.toString(),
          //   //)));
          //   //setState(() {
          //   //insertArt(
          //   //  fetchedHome[index].newsid,
          //   //fetchedHome[index].picture.toString(),
          //   //fetchedHome[index].title.toString());
          //   // },
          //   //);
          //   //}
          // ),
          //   IconButton(
          //     icon: Icon(Icons.share),
          //     color: Colors.grey,
          //     // onPressed: () {
          //     //  Share.share(
          //     //     'check out this news ' +
          //     // fetchedHome[index].link,
          //     //  subject: fetchedHome[index].title);
          //     //  },
          //   ),
        ],
        backgroundColor: Color(0xff88db52),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WebView(
              initialUrl: postUrl,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
            ),
          ),


        ],
      ),
    );
  }
}

///===================================== class to show story News
class StoryView extends StatelessWidget {
  final String imageStory,
      bodyStory,
      titleStory,
      storyDate,
      storytitle,
      newsLink;
  final String storyId;

  StoryView(
      {@required this.storyId,
      this.imageStory,
      this.bodyStory,
      this.titleStory,
      this.storyDate,
      this.storytitle,
      this.newsLink});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => NewsCubit()
          ..getNews(storyId)
          ..initDb(),
        child: BlocConsumer<NewsCubit, NewsStates>(
            builder: (context, states) {
              var cubit = NewsCubit.get(context);

              return Scaffold(
                appBar: AppBar(
                  //   centerTitle: true,
                  // title: Row(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     Image.asset(
                  //       'images/menafn_logo.png',
                  //       height: 31,
                  //       alignment: Alignment.center,
                  //     )
                  //   ],
                  // ),
                  actions: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        await cubit
                            .insertArt(
                                id: cubit.oneStory[0].newsID,
                                imagePath:
                                    cubit.oneStory[0].imagePath.toString(),
                                newsTitle: cubit.oneStory[0].title.toString(),
                                link: cubit.oneStory[0].newsLink)
                            .then((value) {
                          print(value);
                        });
                      },
                      child: Icon(Icons.save_alt_sharp),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await Share.share(
                                'check out this news ' +
                                    cubit.oneStory[0].newsLink,
                                subject: cubit.oneStory[0].title)
                            .then((value) {
                          print('goooodd');
                        });
                      },
                      child: Icon(Icons.share),
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                  backgroundColor: Color(0xff88db52),
                  elevation: 0.0,
                ),
                bottomSheet:   Container(
                  //height: _height,
                  height: 55,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child:google_ads(),

                ),
                // bottomNavigationBar: BottomNavigationBar(
                //     type: BottomNavigationBarType.fixed,
                //     backgroundColor: Colors.white,
                //     currentIndex: currentIndex,
                //     selectedItemColor: Color(0xff88db52),
                //     onTap: (index) {
                //       setState(() {
                //         currentIndex = index;
                //       });
                //     },
                //
                //
                //     // Color(0xe9eaed) gray
                //     items: [
                //       BottomNavigationBarItem(
                //         title: Text("home"),
                //         icon: Icon(Icons.home),
                //
                //       ),
                //
                //       BottomNavigationBarItem(
                //         title: Text("saved"),
                //         icon: Icon(Icons.save_alt_sharp),
                //       on
                //
                //       ),
                //
                //     ]
                // ),
                body: PageView.builder(
                  itemCount: cubit.oneStory.length,
                  itemBuilder: (BuildContext context, int index) => CardItem(
                    contant: cubit.oneStory[index].newsBody ?? "",
                    head: cubit.oneStory[index].newsDate ?? "",
                    picUrl: cubit.oneStory[index].imagePath ?? "",
                    title: cubit.oneStory[index].newsTitle ?? "",
                    newsid: cubit.oneStory[index].newsID ?? null,
                    nLink: cubit.oneStory[index].newsLink ?? "",
                    disc: cubit.oneStory[index].newsDisclaimer ?? "",
                    logo: cubit.oneStory[index].providerLogo ?? "",
                  ),
                ),
              );
            },
            listener: (context, states) {}));
  }
}

class CardItem extends StatelessWidget {
  final String picUrl, head, contant, title, imgUrl, nLink, disc, logo;

  final int newsid;
  CardItem({
    this.picUrl,
    this.head,
    this.contant,
    this.title,
    this.newsid,
    this.imgUrl,
    this.nLink,
    this.disc,
    this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Container(
        height: 300.0,
        color: Colors.white,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: 0,
                ),
                Center(
                  child: ClipRRect(
                    //borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      picUrl,
                      height: 260,
                      // width: 500,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

                Html(
                  data: title,
                  padding: EdgeInsets.all(15),
                  defaultTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(
                  height: 0,
                ), /////12
                // Text(
                Center(
                  child: Container(
                    child: Html(
                      data: head,
                      padding: EdgeInsets.only(left: 20, top: 0),
                    ),
                  ),
                ),
                //  SizedBox(
                //     height: 4,
                //   ),

                Html(
                  data: contant,
                  padding: EdgeInsets.only(left: 20, top: 30, right: 20),
                  // optional, type Function

                  onLinkTap: (url) {
                    print(url);
                    launch(url);
                  },

                  defaultTextStyle: TextStyle(
                    // color: Colors.black54,
                    fontSize: 20,
                    wordSpacing: 3,
                    height: 1.3,

                    //letterSpacing: 1,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Montserrat',
                    color: Color.fromRGBO(38, 38, 38, 0.749019607843373),
                  ),
                ),

                // Padding(
                //   padding: EdgeInsets.only(right: 200),
                //   child: Center(

                // child: InkWell(
                // padding: EdgeInsets.only(right: 200),
                //alignment: Alignment.centerLeft,
                /* onTap: () {
                        print(url);
                        launch(url);
                      },*/

                // child: Container(
                // child:
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Image.network(
                          logo,
                          alignment: Alignment.centerLeft,
                        ),
                      )),
                ),
                Container(
                  //height: _height,
                  height: 55,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child:google_ads(),

                ),
                //   ),
                // ),
                // ),
                //),
                Html(
                  data: disc,
                  padding: EdgeInsets.only(left: 20, top: 30),
                  defaultTextStyle: TextStyle(
                    // color: Colors.black54,
                    fontSize: 20,
                    wordSpacing: 3,
                    height: 1.3,

                    //letterSpacing: 1,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Montserrat',
                    color: Color.fromRGBO(38, 38, 38, 0.749019607843373),
                  ),
                ),


              ],
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),

            //     )
            // ],
            // ),
          ],
        ),
      ),
    );
  }
}

class Photo1 {
  final int newsid;
  final String newsdate;
  final String title;
  final String picture;
  final String company;
  final String link;

  Photo1(this.newsid, this.newsdate, this.title, this.picture, this.company,
      this.link);

  factory Photo1.fromJson(Map<String, dynamic> json) {
    return Photo1(json["newsid"], json["newsdate"], json["title"],
        json["picture"], json["company"], json["link"]);
  }

  static List<Photo1> parseList(List<dynamic> list) {
    return list.map((i) => Photo1.fromJson(i)).toList();
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "newsid": newsid == null ? null : newsid,
        "newsdate": newsdate == null ? null : newsdate,
        "title": title == null ? null : title,
        "picture": picture == null ? null : picture,
        "company": company == null ? null : company,
        "link": link == null ? null : link,
      };
}
