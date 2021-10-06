import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:menafn/shared/bloc_observer.dart';



import 'layout/news_app/cubit/cubit.dart';
import 'layout/news_app/cubit/states.dart';
import 'modules/bottomnav/bottomnav.dart';


void main()async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  //  await MobileAds.instance.initialize().then((InitializationStatus status) {
  //    print('Initialization done: ${status.adapterStatuses}');
  //  MobileAds.instance.updateRequestConfiguration(
  //  RequestConfiguration(
  //      tagForChildDirectedTreatment:
  //      TagForChildDirectedTreatment.unspecified,
  //      testDeviceIds: <String>[]),//when you run first time you will get your test id in logs then update it here <String>["test id"]
  // );
  // });
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()
        ..initDb(),
        child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
    builder: (context, state) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          bottomNavigationBarTheme: BottomNavigationBarThemeData
            (
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color(0xff88db52),
            backgroundColor: Colors.white,
            elevation: 20.0,

          ),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Color(0xff88db52),
              statusBarIconBrightness: Brightness.light,
            ),
            backwardsCompatibility: false,
            backgroundColor: Color(0xff88db52),
            elevation: 0.0,
          ),

        ),
        debugShowCheckedModeBanner: false,
        home: bottomNav(),

      );
    })
      );
  }

}

