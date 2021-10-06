import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menafn/layout/news_app/cubit/cubit.dart';
import 'package:menafn/layout/news_app/cubit/states.dart';

class bottomNav extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return    BlocProvider(
      create: (BuildContext context) => NewsCubit()..initDb(),
      child: BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = NewsCubit.get(context);
            return Scaffold(
              appBar: AppBar(

                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'images/menafn_logo.png',
                      height: 31,
                    )
                  ],
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                  onTap: (index) {
                    cubit.changeBottomNavBar(index);
                  },
                  currentIndex: cubit.currentIndex,
                  items: cubit.bottomItems),
              body:cubit.screen[cubit.currentIndex],

            );
          }),
    );
  }
}
