// import 'package:flutter/material.dart';
//
// import '../../../objects/ExperiencePost.dart';
// import '../../../services/database_service.dart';
// import '../../../values/Home_Screen_Fonts.dart';
// import 'package:intl/intl.dart';
// import 'detail_post_screen.dart';
//
//
// class PostOfTopic extends StatefulWidget {
//   String idTopic;
//   String name;
//   PostOfTopic({Key? key,required this.idTopic,required this.name}) : super(key: key);
//
//
//   @override
//   State<PostOfTopic> createState() => _PostOfTopicState();
// }
//
// class _PostOfTopicState extends State<PostOfTopic> {
//
//   late List<ExperiencePost> _post;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   void getPostOfTopic()
//   {
//     _post=_post.where((element) => element.topic_id!.contains(this.widget.idTopic)).toList();
//
//   }
//
//   AppBar _buildAppBar() {
//     return AppBar(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       title: Text(
//         'Topic about '+widget.name,
//         style: HomeScreenFonts.headStyle,
//       ),
//     );
//   }
//
//   String parseDateTime(DateTime? date) {
//     DateFormat formatter = DateFormat('dd/MM/yyyy');
//     String created_at;
//     if (date != null) {
//       created_at = formatter.format(date);
//     } else {
//       created_at = '01/01/2001';
//     }
//     return created_at;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar(),
//       backgroundColor: const Color.fromARGB(255, 233, 240, 243),
//       body: ListView(
//         children: [
//           FutureBuilder(
//             future: DatabaseService().allExperiencePostsOnce,
//             builder:
//                 (BuildContext context, AsyncSnapshot<List<ExperiencePost>?> snapshot) {
//               if (snapshot.hasError) {
//                 return Text('Something went wrong :(');
//               }
//               if (snapshot.data == null ||
//                   snapshot.connectionState == ConnectionState.waiting) {
//                 return Column(
//                   children: [
//                     CircularProgressIndicator(),
//                   ],
//                 );
//               }
//               _post = snapshot.data! as List<ExperiencePost>;
//
//               print(_post.length);
//               getPostOfTopic();
//               return topicBuilder();
//             },
//           ),
//         ],
//       ),
//     );  }
//
//     Column topicBuilder()
//     {
//       return Column(
//           children: _post!
//               .map(
//                 (eachPost) => GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (_) => PostScreen(experiencePost: eachPost)));
//               },
//               child: Container(
//                 height: 180,
//                 margin: const EdgeInsets.all(12.0),
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10.0),
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.black26.withOpacity(0.1),
//                           blurRadius: 8.0,
//                           offset: const Offset(5, -5.0),
//                           spreadRadius: 0.10),
//                     ]),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Container(
//                         height: 70,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Row(
//                               children: <Widget>[
//                                 const CircleAvatar(
//                                   backgroundImage: AssetImage(
//                                       'assets/images/avatar.png'),
//                                   radius: 22,
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 8.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.start,
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       Container(
//                                         width: MediaQuery.of(context)
//                                             .size
//                                             .width *
//                                             0.65,
//                                         child: Text(
//                                           eachPost.title ??
//                                               'Title is null',
//                                           style: const TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                               letterSpacing: .4),
//                                         ),
//                                       ),
//                                       const SizedBox(height: 2.0),
//                                       Row(
//                                         children: <Widget>[
//                                           Text(
//                                             'Admin',
//                                             style: TextStyle(
//                                                 color: Colors.grey
//                                                     .withOpacity(0.6)),
//                                           ),
//                                           const SizedBox(width: 16),
//                                           Text(
//                                             parseDateTime(eachPost.created_at),
//                                             style: TextStyle(
//                                                 color: Colors.grey
//                                                     .withOpacity(0.6)),
//                                           )
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         height: 50,
//                         child: Center(
//                           child: Text(
//                             (eachPost.content?.length ?? 0) > 80 ? "${eachPost.content?.substring(0, 80)}..":"${eachPost.content}" ,
//                             style: TextStyle(
//                                 color: Colors.grey.withOpacity(0.8),
//                                 fontSize: 16,
//                                 letterSpacing: .3),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: <Widget>[
//                               Icon(
//                                 Icons.favorite,
//                                 color: Colors.grey.withOpacity(0.6),
//                                 size: 22,
//                               ),
//                               const SizedBox(width: 4.0),
//                               Text(
//                                 "${eachPost.liked_users?.length ?? 0} likes",
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     color: Colors.grey.withOpacity(0.6),
//                                     fontWeight: FontWeight.w600),
//                               )
//                             ],
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Icon(
//                                 Icons.comment,
//                                 color: Colors.grey.withOpacity(0.6),
//                                 size: 16,
//                               ),
//                               const SizedBox(width: 4.0),
//                               Text(
//                                 "${eachPost.comments?.length ?? 0} comment",
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     color: Colors.grey.withOpacity(0.6)),
//                               )
//                             ],
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           )
//               .toList());
//     }
// }



import 'package:flutter/material.dart';
import '../../../objects/ExperiencePost.dart';
import '../../../services/database_service.dart';
import '../../../values/Home_Screen_Fonts.dart';
import 'package:intl/intl.dart';
import 'detail_post_screen.dart';


class PostOfTopic extends StatefulWidget {
  String idTopic;
  String name;
  PostOfTopic({Key? key,required this.idTopic,required this.name}) : super(key: key);


  @override
  State<PostOfTopic> createState() => _PostOfTopicState();
}

class _PostOfTopicState extends State<PostOfTopic> {

  late List<ExperiencePost>? _post;

  @override
  void initState() {
    super.initState();
  }

  void getPostOfTopic()
  {
    _post=_post?.where((element) => element.topic_id!.contains(widget.idTopic)).toList();

  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(
        'Topic about '+widget.name,
        style: HomeScreenFonts.headStyle,
      ),
    );
  }

  String parseDateTime(DateTime? date) {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    String created_at;
    if (date != null) {
      created_at = formatter.format(date);
    } else {
      created_at = '01/01/2001';
    }
    return created_at;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: const Color.fromARGB(255, 233, 240, 243),
      body: ListView(
        children: [
          FutureBuilder(
            future: DatabaseService().allExperiencePostsOnce,
            builder:
                (BuildContext context, AsyncSnapshot<List<ExperiencePost>?> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong :(, post ,${snapshot.error}');
              }
              if (snapshot.data == null ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  children: const [
                    CircularProgressIndicator(),
                  ],
                );
              }
              _post = snapshot.data! as List<ExperiencePost>;


              getPostOfTopic();
              return topicBuilder();
            },
          ),
        ],
      ),
    );  }

  Column topicBuilder()
  {
    return Column(
        children: _post!
            .map(
              (eachPost) => GestureDetector(
            onTap: ()  {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => PostScreen(experiencePost: eachPost)));
            },
            child: Container(
              height: 180,
              margin: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26.withOpacity(0.1),
                        blurRadius: 8.0,
                        offset: const Offset(5, -5.0),
                        spreadRadius: 0.10),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/images/avatar.png'),
                                radius: 22,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.65,
                                      child: Text(
                                        eachPost.title ??
                                            'Title is null',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: .4),
                                      ),
                                    ),
                                    const SizedBox(height: 2.0),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'Admin',
                                          style: TextStyle(
                                              color: Colors.grey
                                                  .withOpacity(0.6)),
                                        ),
                                        const SizedBox(width: 16),
                                        Text(
                                          parseDateTime(eachPost.created_at),
                                          style: TextStyle(
                                              color: Colors.grey
                                                  .withOpacity(0.6)),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      child: Center(
                        child: Text(
                          (eachPost.content?.length ?? 0) > 80 ? "${eachPost.content?.substring(0, 80)}..":"${eachPost.content}" ,
                          style: TextStyle(
                              color: Colors.grey.withOpacity(0.8),
                              fontSize: 16,
                              letterSpacing: .3),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.favorite,
                              color: Colors.grey.withOpacity(0.6),
                              size: 22,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              "${eachPost.liked_users?.length ?? 0} likes",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.withOpacity(0.6),
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.comment,
                              color: Colors.grey.withOpacity(0.6),
                              size: 16,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              "${eachPost.numberOfComments } comment",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.withOpacity(0.6)),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
            .toList());
  }
}
