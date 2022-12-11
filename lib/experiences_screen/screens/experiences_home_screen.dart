// import 'package:flutter/material.dart';
// import 'package:flutter_interview_preparation/experiences_screen/components/interactive_bloc.dart';
// import 'package:flutter_interview_preparation/experiences_screen/components/interactive_stream_builder.dart';
// import 'package:flutter_interview_preparation/objects/ExperiencePost.dart';
// import 'package:intl/intl.dart';
//
// import '../screens/detail_post_screen.dart';
// import '../screens/experiences_home_screen.dart';
//
// class Posts extends StatefulWidget {
//   final List<ExperiencePost>? post;
//   Posts({required this.post});
//   @override
//   _PostsState createState() => _PostsState();
// }
//
// class _PostsState extends State<Posts> {
//   var defaultInteractiveBloc =
//   InteractiveBloc(numberOfComments: 0, numberOfLikes: 0);
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//         children: widget.post!
//             .map(
//               (eachPost) => GestureDetector(
//             onTap: () {
//               print(eachPost.toString());
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (_) =>
//                           PostScreen(experiencePost: eachPost)));
//             },
//             child: Container(
//               height: 180,
//               margin: const EdgeInsets.all(12.0),
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10.0),
//                   boxShadow: [
//                     BoxShadow(
//                         color: Colors.black26.withOpacity(0.1),
//                         blurRadius: 8.0,
//                         offset: const Offset(5, -5.0),
//                         spreadRadius: 0.10),
//                   ]),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Container(
//                       height: 70,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Row(
//                             children: <Widget>[
//                               const CircleAvatar(
//                                 backgroundImage:
//                                 AssetImage('assets/images/avatar.png'),
//                                 radius: 22,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 8.0),
//                                 child: Column(
//                                   crossAxisAlignment:
//                                   CrossAxisAlignment.start,
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     Container(
//                                       width: MediaQuery.of(context)
//                                           .size
//                                           .width *
//                                           0.65,
//                                       child: Text(
//                                         eachPost.title ?? 'Title is null',
//                                         style: const TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold,
//                                             letterSpacing: .4),
//                                       ),
//                                     ),
//                                     const SizedBox(height: 2.0),
//                                     Row(
//                                       children: <Widget>[
//                                         Text(
//                                           'Admin',
//                                           style: TextStyle(
//                                               color: Colors.grey
//                                                   .withOpacity(0.6)),
//                                         ),
//                                         const SizedBox(width: 16),
//                                         Text(
//                                           parseDateTime(
//                                               eachPost.created_at),
//                                           style: TextStyle(
//                                               color: Colors.grey
//                                                   .withOpacity(0.6)),
//                                         )
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       height: 50,
//                       child: Center(
//                         child: Text(
//                           (eachPost.content?.length ?? 0) > 80
//                               ? "${eachPost.content?.substring(0, 80)}.."
//                               : "${eachPost.content}",
//                           style: TextStyle(
//                               color: Colors.grey.withOpacity(0.8),
//                               fontSize: 16,
//                               letterSpacing: .3),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     InteractiveStreamBuilder(
//                         experiencePost: eachPost,
//                         defaultInteractiveBloc: defaultInteractiveBloc,
//                         child: (numberOfLikes, numberOfComments) =>
//                             InteractiveBloc(
//                               numberOfLikes: numberOfLikes,
//                               numberOfComments: numberOfComments,
//                             )),
//                     // Row(
//                     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     //   children: <Widget>[
//                     //     Row(
//                     //       crossAxisAlignment: CrossAxisAlignment.center,
//                     //       children: <Widget>[
//                     //         Icon(
//                     //           Icons.favorite,
//                     //           color: Colors.grey.withOpacity(0.6),
//                     //           size: 22,
//                     //         ),
//                     //         const SizedBox(width: 4.0),
//                     //         Text(
//                     //           "${eachPost.liked_users?.length ?? 0} likes",
//                     //           style: TextStyle(
//                     //               fontSize: 14,
//                     //               color: Colors.grey.withOpacity(0.6),
//                     //               fontWeight: FontWeight.w600),
//                     //         )
//                     //       ],
//                     //     ),
//                     //     Row(
//                     //       children: <Widget>[
//                     //         Icon(
//                     //           Icons.comment,
//                     //           color: Colors.grey.withOpacity(0.6),
//                     //           size: 16,
//                     //         ),
//                     //         const SizedBox(width: 4.0),
//                     //         Text(
//                     //           "${eachPost.comments?.length ?? 0} comment",
//                     //           style: TextStyle(
//                     //               fontSize: 14,
//                     //               color: Colors.grey.withOpacity(0.6)),
//                     //         )
//                     //       ],
//                     //     ),
//
//                     //   ],
//                     // )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         )
//             .toList());
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
// }

import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/ExperiencePost.dart';

import '../../../objects/Comment.dart';
import '../../../services/database_service.dart';
import '../components/popular_topic.dart';
import '../components/post.dart';
import '../components/top_bar.dart';
class ExperienceHome extends StatefulWidget {



  @override
  _ExperienceHomeState createState() => _ExperienceHomeState();

}


class _ExperienceHomeState extends State<ExperienceHome> {
  late List<ExperiencePost> _post;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseService().allExperiencePostsOnce,
      builder:
          (BuildContext context, AsyncSnapshot<List<ExperiencePost>?> snapshot) {
        print(snapshot.error);
        if (snapshot.hasError) {
          // print(snapshot.error);
          return Text('Something went wrong :( DA xay ra loi  ${snapshot.error}');
        }
        if (snapshot.data == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: [
              CircularProgressIndicator(),
            ],
          );
        }
        _post =  snapshot.data! as List<ExperiencePost>;

        print('SL COMMENT : ${_post[0].comments?.length ?? 0}');
        print('hahahahah');
        return Scaffold(

          body: SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: <Color>[
                      Color.fromRGBO(165, 204, 255, 1),
                      Color.fromRGBO(115, 104, 226, 1)
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight)
                ),
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: 160,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(

                          gradient: LinearGradient(colors: <Color>[
                            Color.fromRGBO(165, 204, 255, 1),
                            Color.fromRGBO(115, 104, 226, 1)
                          ], begin: Alignment.centerLeft, end: Alignment.centerRight)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              "Have a good day!",
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Find Topics you like to read",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 14.0,
                                  ),
                                ),
                                const Icon(
                                  Icons.search,
                                  size: 20,
                                  color: Colors.white,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(35.0),
                                topRight: Radius.circular(35.0)
                            )
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TopBar(),
                            const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                "Popular Topics",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                ),
                              ),
                            ),
                            PopularTopics(),
                            const Padding(
                              padding: EdgeInsets.only(left: 20.0, top: 20.0, bottom: 10.0),
                              child: Text(
                                "Trending Posts",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Posts(post: _post),
                          ],
                        )
                    )
                  ],
                ),
              )
          ),
        );
      },
    );

  }
}