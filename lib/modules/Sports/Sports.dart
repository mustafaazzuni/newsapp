
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menafn/layout/news_app/cubit/cubit.dart';
import 'package:menafn/layout/news_app/cubit/states.dart';
import 'package:menafn/modules/artical_view/article_view.dart';
import 'package:menafn/shared/native_inline_page.dart';


import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share/share.dart';
class SportsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    RefreshController _refreshController =
    RefreshController(initialRefresh: false);
    return BlocProvider(
        create: (BuildContext context) => NewsCubit()..getSports(),
        child: BlocConsumer<NewsCubit, NewsStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = NewsCubit.get(context);
              return  SmartRefresher(
                controller: _refreshController,
                enablePullUp: true,
                onLoading: cubit.RefreshSports,
                enablePullDown: false,
                // return null;
                child: ListView.builder(
                  itemCount: cubit.Sports.length ,
                  itemBuilder: (context, index) {


                    final Photo photo = cubit.Sports[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StoryView(
                                      storyId: photo.newsid.toString(),
                                  )));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 220,
                              decoration: BoxDecoration(
                                // border: Border.all(width: 0, style: BorderStyle.none),
                                //borderRadius: BorderRadius.circular(0.0),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      photo.picture,
                                    ),
                                    fit: BoxFit.contain,

                                    // fit: BoxFit.fill,
                                  )),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent.withOpacity(0),
                                            Colors.black.withOpacity(0.5),
                                            Colors.black.withOpacity(1)
                                          ])),
                                  child: Text(
                                    photo.title,
                                    style: TextStyle(
                                      // fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.save_alt_sharp),
                                  color: Colors.grey,
                                  onPressed: () {
                                    // Navigator.push(
                                    //            context,
                                    //             MaterialPageRoute(
                                    //       builder: (context) => StoryView(
                                    //       storyId: fetchedHome[index].newsid.toString(),
                                    //        )));
                                    //  setState(() {
                                    //  insertArt(
                                    //    fetchedHome[index].newsid,
                                    //  fetchedHome[index].picture.toString(),
                                    //fetchedHome[index].title.toString());
                                  },
                                ),



                                IconButton(
                                  icon: Icon(Icons.share),
                                  color: Colors.grey,
                                  onPressed: () {
                                       Share.share(
                                         'check out this news ' +
                                           cubit.Sports[index].link,
                                     subject: cubit.Sports[index].title);
                                  },
                                ),
                              ]),
                          /* IconButton(
                        icon: Icon(Icons.bookmark_border),
                        color: Colors.grey,
                       /* onPressed: () async{
                          final box = GetStorage();
                          print(box.read('bookmark'));
                          List<dynamic> list=box.read('bookmark');
                          if(list!=null){
                            list.add(photo);
                            await box.write('bookmark', list);
                          }else{
                            list=[];
                            list.add(photo);
                            await box.write('bookmark', list);
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BokkmarksScreen()));
                        },*/
                      ),*/
                          SizedBox(
                            height: 5,
                          ),

                          if (index % 5 == 0)
                            Container(
                              //height: _height,
                                height: 250,
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(bottom: 10.0),
                              child: NativeInlinePage(),
                              //Text("test ads")
                              //     adContainer                              //  _bannerAd()
                              // NativeAdmob(
                              //   // Your ad unit id
                              //   adUnitID: _adUnitID,
                              //   controller: _nativeAdController,

                              //   // Don't show loading widget when in loading state
                              //   loading: Container(),
                              // ),
                            ),
                        ],
                      ),


                      // Container(
                      //     height: _height,
                      //     padding: EdgeInsets.all(10),
                      //     margin: EdgeInsets.only(bottom: 20.0),
                      //     child: Text("test ads 1")
                      //   // NativeAdmob(
                      //   //   // Your ad unit id
                      //   //   adUnitID: _adUnitID,
                      //   //   controller: _nativeAdController,
                      //   //   numberAds: 1,
                      //
                      //   //   // Don't show loading widget when in loading state
                      //   //   loading: Container(),
                      //   // ),
                      // ),

                    );

                  },
                ),
              );

            }
        )
    );


  }

// final Container adContainer = Container(
//     alignment: Alignment.center,
//   child: adWidget,
// width: myBanner.size.width.toDouble(),
//  height: myBanner.size.height.toDouble(),
// );
}
