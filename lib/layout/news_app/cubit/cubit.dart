import 'dart:convert';


import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:http/http.dart' as http;
import 'package:menafn/layout/news_app/cubit/states.dart';
import 'package:menafn/models/productsCla/ViewOneStory.dart';
import 'package:menafn/modules/Save/Save_art.dart';
import 'package:menafn/modules/artical_view/article_view.dart';
import 'package:menafn/modules/search/search.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sqflite/sqflite.dart';
import '../news_layout.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  int _pageNumberSports = 1;
  int _pageNumberPolitics = 1;
  int _pageNumberCrypto = 1;
  int _pageNumberEntertainment = 1;
  int _pageNumberHome = 1;
  int _pageNumberHealth = 1;
  int _pageNumberEnergy = 1;
  int _pageNumberTelecom = 1;
  int currentIndex1 = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
    BottomNavigationBarItem(icon: Icon(Icons.archive), label: 'Save'),
  ];

  List<Widget> screen = [
    NewsLayout(),
    SearchScreen(),
    SaveArt(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(NewsBottomNavState());
  }
  List<Photo> Home = [];

  void getHome() async {
    emit(getHomeState());
    try {
      final response = await http.get(Uri.parse(
          "https://menafn.com/mobile/WebAPI/getnews/getsection/MobileEN_Home-$_pageNumberHome"));
      Home.addAll(Photo.parseList(json.decode(response.body)));
      emit(getHomeState());
      changepageNumberHome();
      emit(changepageNumberHomeState());

    } catch (error) {
      print(error);
    }
  }

  void changepageNumberHome() {
    print('pageNumberHome$_pageNumberHome');
    _pageNumberHome++;
    emit(changepageNumberHomeState());
  }

  void  loadHome()  {
   getHome();
    emit(loadhHomeState());
  }

  void  RefreshHome()  {
    _pageNumberHome=0;
    getHome();
    emit(RefreshHomeState());
  }

  List<Photo> Politics = [];

  void getPolitics() async {
    try {
      final response = await http.get(Uri.parse(
          "https://menafn.com/mobile/WebAPI/getnews/getsection/MobileEN_Politics-$_pageNumberPolitics"));
      Politics.addAll(Photo.parseList(json.decode(response.body)));
      _pageNumberPolitics++;
      emit(getPoliticsState());
    } catch (error) {
      print(error);
    }
  }

  List<Photo> Crypto = [];

  void getCrypto() async {
    try {
      final response = await http.get(Uri.parse(
          "https://menafn.com/mobile/WebAPI/getnews/getsection/MobileEN_Crypto-$_pageNumberCrypto"));
      Crypto.addAll(Photo.parseList(json.decode(response.body)));
      _pageNumberCrypto++;
      emit(getCryptoState());
    } catch (error) {
      print(error);
    }
  }

  List<Photo> Entertainment = [];

  void getEntertainment() async {
    try {
      final response = await http.get(Uri.parse(
          "https://menafn.com/mobile/WebAPI/getnews/getsection/MobileEN_Entertainment-$_pageNumberEntertainment"));
      Entertainment.addAll(Photo.parseList(json.decode(response.body)));
      _pageNumberEntertainment++;
      emit(getEntertainmentStateState());
    } catch (error) {
      print(error);
    }
  }

  List<Photo> Sports = [];

  void getSports() async {
    try {
      final response = await http.get(Uri.parse(
          "https://menafn.com/mobile/WebAPI/getnews/getsection/MobileEN_Sports-$_pageNumberSports"));
      Sports.addAll(Photo.parseList(json.decode(response.body)));
      _pageNumberSports++;
      emit(getSportsState());
    } catch (error) {
      print(error);
    }
  }

  List<Photo> Energy = [];

  void getEnergy() async {
    try {
      final response = await http.get(Uri.parse(
          "https://menafn.com/mobile/WebAPI/getnews/getsection/MobileEN_Energy-$_pageNumberEnergy"));
      Energy.addAll(Photo.parseList(json.decode(response.body)));
      _pageNumberEnergy++;
      emit(getEnergyState());
    } catch (error) {
      print(error);
    }
  }

  List<Photo> Health = [];

  void getHealth() async {
    try {
      final response = await http.get(Uri.parse(
          "https://menafn.com/mobile/WebAPI/getnews/getsection/MobileEN_Health-$_pageNumberHealth"));
      Health.addAll(Photo.parseList(json.decode(response.body)));
      _pageNumberHealth++;
      emit(getHealthState());
    } catch (error) {
      print(error);
    }
  }

  List<Photo> Telecom = [];

  void getTelecom() async {
    try {
      final response = await http.get(Uri.parse(
          "https://menafn.com/mobile/WebAPI/getnews/getsection/MobileEN_Telecom-$_pageNumberTelecom"));
      Telecom.addAll(Photo.parseList(json.decode(response.body)));
      _pageNumberTelecom++;
      emit(getTelecomState());
    } catch (error) {
      print(error);
    }
  }

  List<ViewOneStory> oneStory = [];

  Future<List<ViewOneStory>> getNews(storyId) async {
    var data = await http.get(Uri.parse(
        'https://menafn.com/mobile/WebAPI/getnews/getstory/$storyId'));

    var jsonData = json.decode(data.body);
    print('**************');
    print(jsonData);
    print('**************');
    for (var u in jsonData) {
      ViewOneStory story = ViewOneStory(
          u["newsID"],
          u["newsTitle"],
          u["newsDate"],
          u["imagePath"],
          u["providerName"],
          u["newsLink"],
          u["providerLogo"],
          u["newsDisclaimer"],
          u["newsBody"],
          u["title"]);
      print('+++++++++++++++++++++++++++++++++++++++++++++++++++++++');
      debugPrint(story.toString());
      print('+++++++++++++++++++++++++++++++++++++++++');
      oneStory.add(story);
      print(storyId);
    }
    emit(getNewsState());
    return oneStory;
  }

  var newslist;
  Future<void> share(int id) async {
    CardItem(
      nLink: oneStory[id].newsLink ?? "",
    );
    emit(shareState());
  }
  List<Map> tasks=[];
  Database database;


   initDb()  {
     openDatabase(
      'saveart1.db',
      version: 2,
      onCreate: (database, version) {
        print("database created");
        database.execute(
                'CREATE TABLE saveArt1 (id INTEGER PRIMARY KEY, newsId INTEGER, imagePath Text, newsTitle Text ,link Text )');
      },
      onOpen: (database) {
        getDataFromDatabase(database);


        print('database opened ');

      }).then((value){
       database = value;
       emit(initDbState());
    }).catchError((error){print('error${error}');});
  }


    Icon icon;
   insertArt({
    @required  int id,
    @required  String imagePath,
    @required  String newsTitle,
    @required String link,


   })
  async
  {
    bool SelectColor = false;
    var result = await database.rawQuery(
      'SELECT count(newsId)  FROM saveArt1 WHERE  newsId = $id ',
    );
    //int exists = Sqflite.firstIntValue(result);
    int count =result[0]['count(newsId)'];
    //print("count:$result");
    print('id:$id');
    if (count == 0 )
    {

      print ('SelectColor $SelectColor');
      await database.transaction((txn) {
        txn.rawInsert(
            'INSERT INTO saveArt1 (newsId, imagePath, newsTitle, link) VALUES("$id", "$imagePath", "$newsTitle","$link")'
        );
        return null;
      }).then((value) {
        icon = Icon(Icons.bookmark_added,color: Color(0xff88db52));
        getDataFromDatabase(database);
        print('insert row done $id');

      }).catchError((error) {
        print('not insert $error');
      });
    }else
    {

      await database
          .rawDelete('DELETE FROM saveArt1 WHERE newsId = $id').then((value) => print('newsdelete'));

     icon = Icon(Icons.bookmark_outline) ;
      print ('SelectColor $SelectColor');
    }
    
    emit(insertArtState());

           }






 void getDataFromDatabase(database){

     tasks=[];
     emit(LoadDataFromDatabaseState());
     database.rawQuery('SELECT * FROM saveArt1 ORDER BY id DESC').then((value){
     value.forEach((element) {
       tasks.add(element);
     });
        emit(getDataFromDatabaseState());
      });
  }


  void deleteartFromDatabase(id)async{

    await database.rawDelete('DELETE FROM saveArt1 WHERE newsid = $id');
    emit(deleteartFromDatabaseState());
  }










void  RefreshSave()  {
  emit(LoadDataFromDatabaseState());

  tasks=[];
    database.rawQuery('SELECT * FROM saveArt1 ORDER BY id DESC').then((value){
      value.forEach((element) {
        tasks.add(element);
      });
      emit(RefreshSaveState());
    });

  }


























  RefreshController refreshController ;









  Future<Null> RefreshPolitics() async {
    await getPolitics();

    emit(RefreshPoliticsState());
    return null;
  }

  Future<Null> RefreshCrypto() async {
    await getCrypto();
    emit(RefreshCryptoState());
    return null;
  }


  Future<Null> RefreshSports() async {
    await getSports();
    emit(RefreshSportsState());

    return null;
  }


  Future<Null> RefreshEntertainment() async {
    await getEntertainment();
    emit(RefreshEntertainmentState());

    return null;
  }

  Future<Null> RefreshEnergy() async {
    await getEnergy();
    emit(RefreshEnergyState());

    return null;
  }

  Future<Null> RefreshHealth() async {
    await getHealth();
    emit(RefreshHealthState());

    return null;
  }

  Future<Null> RefreshTelecom() async {
    await getTelecom();
    emit(RefreshTelecomState());

    return null;
  }
  // Future<Null> RefreshHealth() async {
  //   await fetchHealth();
  //   return null;
  // }

  // Future<Null> RefreshEnergy() async {
  //   await fetchEnergy();
  //   return null;
  // }

  // Future<Null> RefreshTelecom() async {
  //   await fetchTelecom();
  //   return null;
  // }

}

class Photo {
  final int newsid;
  final String newsdate;
  final String title;
  final String picture;
  final String company;
  final String link;

  Photo(this.newsid, this.newsdate, this.title, this.picture, this.company,
      this.link);

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(json["newsid"], json["newsdate"], json["title"],
        json["picture"], json["company"], json["link"]);
  }

  static List<Photo> parseList(List<dynamic> list) {
    return list.map((i) => Photo.fromJson(i)).toList();
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

