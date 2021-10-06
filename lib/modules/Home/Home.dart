import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:menafn/layout/news_app/cubit/cubit.dart';
import 'package:menafn/layout/news_app/cubit/states.dart';
import 'package:menafn/modules/artical_view/article_view.dart';
import 'package:menafn/shared/native_inline_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share/share.dart';

class HomeScreen extends StatelessWidget {

  @override

  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => NewsCubit()
          ..initDb()
          ..getHome(),

        child: BlocConsumer<NewsCubit, NewsStates>(
            listener: (context, state) {},
            builder: (context, state) {
              RefreshController refreshController = RefreshController();
              var cubit = NewsCubit.get(context);
              bool select = false ;
              return SmartRefresher(
                controller: refreshController,
                enablePullUp: true,
                enablePullDown: false,
                onLoading: cubit.loadHome,
                child: ListView.builder(
                  itemCount: cubit.Home.length,
                  itemBuilder: (context, index) {

                    final Photo photo = cubit.Home[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => StoryView(
                                                storyId:
                                                    photo.newsid.toString(),
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

                                    Container(
                                      child: IconButton(
                                       icon:cubit.icon,
                                       onPressed: () {

                                            cubit.insertArt(
                                                id: cubit.Home[index].newsid,
                                                imagePath:
                                                    cubit.Home[index].picture,
                                                newsTitle:
                                                    cubit.Home[index].title,
                                                link: cubit.Home[index].link);


                                       },

                                          ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.share),
                                      color: Colors.grey,
                                      onPressed: () {
                                        Share.share(
                                            'check out this news ' +
                                                cubit.Home[index].link,
                                            subject: cubit.Home[index].title);
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
                            ],
                          ),
                          if (index % 5 == 0)
                            Container(
                              //height: _height,
                              height: 260,
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(bottom: 10.0),
                              child: NativeInlinePage(),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }));
  }
}
