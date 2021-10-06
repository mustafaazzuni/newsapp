
//import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';

//import 'package:menafn_devdev/layout/news_app/cubit/cubit.dart';
//import 'package:menafn_devdev/layout/news_app/cubit/states.dart';
//import 'package:menafn_devdev/modules/artical_view/article_view.dart';
//import 'package:menafn_devdev/shared/adsManager.dart';
//import 'package:pull_to_refresh/pull_to_refresh.dart';
//import 'package:share/share.dart';




// class SaveScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (BuildContext context) => NewsCubit(),
//         child: BlocConsumer<NewsCubit, NewsStates>(
//             listener: (context, state) {
//             },
//             builder: (context, state) {
//               var cubit = NewsCubit.get(context);
//               return  ListView.builder(
//                 itemCount: cubit.tasks.length ,
//                 itemBuilder: (context, index) {
//
//                   return Card(
//                     margin: const EdgeInsets.symmetric(horizontal: 0.0),
//                     child: Column(
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => StoryView(
//                                       storyId: cubit.tasks[index]['newsid'],
//                                     )));
//                           },
//                           child: Container(
//                             width: MediaQuery.of(context).size.width,
//                             height: 220,
//                             decoration: BoxDecoration(
//                               // border: Border.all(width: 0, style: BorderStyle.none),
//                               //borderRadius: BorderRadius.circular(0.0),
//                                 image: DecorationImage(
//                                   image: NetworkImage(
//                                     cubit.tasks[index]['picture'],
//                                   ),
//                                   fit: BoxFit.contain,
//
//                                   // fit: BoxFit.fill,
//                                 )),
//                             child: Align(
//                               alignment: Alignment.bottomCenter,
//                               child: Container(
//                                 width: MediaQuery.of(context).size.width,
//                                 padding: const EdgeInsets.all(20),
//                                 decoration: BoxDecoration(
//                                     gradient: LinearGradient(
//                                         begin: Alignment.topCenter,
//                                         end: Alignment.bottomCenter,
//                                         colors: [
//                                           Colors.transparent.withOpacity(0),
//                                           Colors.black.withOpacity(0.5),
//                                           Colors.black.withOpacity(1)
//                                         ])),
//                                 child: Text(
//                                   cubit.tasks[index]['title'],
//                                   style: TextStyle(
//                                     // fontWeight: FontWeight.bold,
//                                       fontSize: 22,
//                                       color: Colors.white),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               IconButton(
//                                   icon: Icon(Icons.save_alt_sharp),
//                                   color: Colors.grey,
//                                   onPressed: () {
//                                     // Navigator.push(
//                                     //            context,
//                                     //             MaterialPageRoute(
//                                     //       builder: (context) => StoryView(
//                                     //       storyId: fetchedHome[index].newsid.toString(),
//                                     //        )));
//
//                                     cubit.insertArt(
//                                         cubit.Home[index].newsid,
//                                         cubit.Home[index].toString(),
//                                         cubit.Home[index].toString(),
//                                         cubit.Home[index].toString()
//                                     );
//                                   }
//                               ),
//
//
//
//                               IconButton(
//                                 icon: Icon(Icons.share),
//                                 color: Colors.grey,
//                                 onPressed: () {
//                                   Share.share(
//                                       'check out this news ' +
//                                           cubit.Home[index].link,
//                                       subject: cubit.Home[index].title);
//                                 },
//                               ),
//                             ]),
//                         /* IconButton(
//                       icon: Icon(Icons.bookmark_border),
//                       color: Colors.grey,
//                      /* onPressed: () async{
//                         final box = GetStorage();
//                         print(box.read('bookmark'));
//                         List<dynamic> list=box.read('bookmark');
//                         if(list!=null){
//                           list.add(photo);
//                           await box.write('bookmark', list);
//                         }else{
//                           list=[];
//                           list.add(photo);
//                           await box.write('bookmark', list);
//                         }
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => BokkmarksScreen()));
//                       },*/
//                     ),*/
//                         SizedBox(
//                           height: 5,
//                         ),
//                       ],
//                     ),
//                   );
//
//                 },
//               );
//
//             }
//         )
//     );
//   }
//
// }
