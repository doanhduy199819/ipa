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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/ExperiencePost.dart';

import '../../../objects/Comment.dart';
import '../../../services/database_service.dart';
import '../../objects/Topic.dart';
import '../../objects/UserBlocked.dart';
import '../../services/auth_service.dart';
import '../components/popular_topic.dart';
import '../components/post.dart';
import '../components/top_bar.dart';


class ExperienceHome extends StatefulWidget {
  @override
  _ExperienceHomeState createState() => _ExperienceHomeState();
}

class _ExperienceHomeState extends State<ExperienceHome> {
  late List<ExperiencePost> _post;
  var topicController = TextEditingController();
  late Future<List<ExperiencePost>?> _dataFuture;
  String topicId = '';
  late Future<List<Topic>?> _topicFuture;
  late bool isAnonymous;
  late Future<List<UserBlocked>?> _userBlockedFuture;

  @override
  void initState() {
    FirebaseFirestore _db = FirebaseFirestore.instance;
    _dataFuture =
        _db.collection('experience').get().then(_experienceFromQuerySnapshot);
    _topicFuture = _db.collection('topic').get().then(_topicsFromQuerySnapshot);
    _userBlockedFuture= _db.collection('userwasblocked').get().then(_userBlockedsFromQuerySnapshot);
    AuthService authService = AuthService();

    isAnonymous = authService.currentUser!.isAnonymous;
    print('ANONYMOUS:${authService.currentUser!.isAnonymous}');
    print('EMAIL:${authService.currentUser!.email}');
    super.initState();
  }


  List<UserBlocked>? _userBlockedsFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    return querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        print('exits');
        return UserBlocked.fromDocumentSnapshot(documentSnapshot);
      }
      return UserBlocked.test();
    }).toList();
  }
  List<Topic>? _topicsFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    return querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return Topic.fromDocumentSnapshot(documentSnapshot);
      }
      return Topic.test();
    }).toList();
  }

  List<ExperiencePost>? _experienceFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    List<ExperiencePost>? res = querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return ExperiencePost.fromDocumentSnapshot(documentSnapshot);
      }
      return ExperiencePost.test();
    }).toList();
    return res;
  }

  Container topicSelection(Topic topic) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color.fromARGB(255, 105, 179, 240),
      ),
      child: InkWell(
        onTap: () {
          topicController.text = (topic.topic_name ?? 'Null');
          //topicName=topic.topic_name??'Null';
          topicId = topic.idTopic;
          print(topicId);
          // setState(() {

          // });
        },
        child: Text(topic.topic_name ?? 'null'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseService().allExperiencePostsOnce,
      builder: (BuildContext context,
          AsyncSnapshot<List<ExperiencePost>?> snapshot) {
        print(snapshot.error);
        if (snapshot.hasError) {
          // print(snapshot.error);
          return Text(
              'Something went wrong :( DA xay ra loi  ${snapshot.error}');
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

        print('SL COMMENT : ${_post[0].comments?.length ?? 0}');
        print('hahahahah');
        return Scaffold(
          body: SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: <Color>[
                      Color.fromRGBO(165, 204, 255, 1),
                      Color.fromRGBO(115, 104, 226, 1)
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: 160,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: <Color>[
                            Color.fromRGBO(165, 204, 255, 1),
                            Color.fromRGBO(115, 104, 226, 1)
                          ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
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
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "What do you think?",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 14.0,
                                  ),
                                ),
                                (isAnonymous == false)
                                    ? IconButton(
                                    onPressed: () async {
                                      var topics = await _topicFuture;
                                      var usersblocked= await _userBlockedFuture;
                                      try{
                                        for(int i=0;i<usersblocked!.length;i++){
                                          if(usersblocked[i].id_user==AuthService().currentUser!.uid){
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    scrollable: true,
                                                    title: const Text(
                                                        'Ban'),
                                                    content: const Center(
                                                      child: Text('User was banned'),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        child: const Text("Return"),
                                                        onPressed: () =>
                                                            Navigator.pop(context),
                                                      ),
                                                    ],
                                                  );
                                                });
                                            return;
                                          }
                                        }
                                      }catch(error){
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {

                                              return AlertDialog(
                                                scrollable: true,
                                                title: const Text(
                                                    'Error'),
                                                content: Center(
                                                  child: Text('${error.toString()}'),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    child: Text("Return"),
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                  ),
                                                ],
                                              );
                                            });
                                      }

                                      //print('Topic: ${topics?.length ?? 0}');
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            String content = "";
                                            var titleController =
                                            TextEditingController();
                                            var contentController =
                                            TextEditingController();

                                            return AlertDialog(
                                              scrollable: true,
                                              title: const Text(
                                                  'Add Experience Post'),
                                              content: Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: Form(
                                                  child: Column(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: 40,
                                                        child: ListView.builder(
                                                          itemBuilder:
                                                              (context, i) {
                                                            return topicSelection(
                                                                topics![i]);
                                                          },
                                                          itemCount:
                                                          topics!.length,
                                                          scrollDirection:
                                                          Axis.horizontal,
                                                          physics:
                                                          const ScrollPhysics(
                                                              parent:
                                                              AlwaysScrollableScrollPhysics()),
                                                        ),
                                                      ),
                                                      // Row(
                                                      //   children: [
                                                      //     ...(topics!.map((e) =>
                                                      //         topicSelection(e))),
                                                      //   ],
                                                      // ),
                                                      TextFormField(
                                                        decoration:
                                                        const InputDecoration(
                                                          labelText: 'Topic',
                                                          //icon: Icon(Icons.account_box),
                                                        ),
                                                        controller:
                                                        topicController,
                                                      ),
                                                      TextFormField(
                                                        decoration:
                                                        const InputDecoration(
                                                          labelText: 'Title',
                                                          //icon: Icon(Icons.account_box),
                                                        ),
                                                        controller:
                                                        titleController,
                                                      ),
                                                      Container(
                                                        height: 10 * 24.0,
                                                        child: TextField(
                                                          controller:
                                                          contentController,
                                                          maxLines: 10,
                                                          decoration:
                                                          InputDecoration(
                                                            hintText: "Content",
                                                            fillColor: Colors
                                                                .lightBlue[100],
                                                            filled: true,
                                                          ),
                                                          onChanged: (value) {
                                                            content = value;
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: Text("Cancel"),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                ),
                                                TextButton(
                                                    child: Text("Submit"),
                                                    onPressed: () {
                                                      ExperiencePost
                                                      experiencePost =
                                                      ExperiencePost(
                                                          null,
                                                          topicId,
                                                          titleController
                                                              .text,
                                                          DateTime.now(),
                                                          contentController
                                                              .text,
                                                          null,
                                                          null,
                                                          0,
                                                          false,
                                                      AuthService().currentUser?.displayName ??'NONAME');
                                                      print(experiencePost
                                                          .toString());
                                                      // experiencePost.setContent(contentController.text);
                                                      // experiencePost.setTitle(titleController.text);
                                                      // experiencePost.setCreated_at(DateTime.now());
                                                      // ExperiencePost.fromJson(
                                                      //     jsonDecode(jsonEncode(experiencePost)));
                                                      DatabaseService()
                                                          .addExperiencePost(
                                                          experiencePost);

                                                      Navigator.pop(context);
                                                    })
                                              ],
                                            );
                                          });
                                    },
                                    icon: const Icon(Icons.add,
                                        color: Colors.white))
                                    : Container(),
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
                                topRight: Radius.circular(35.0))),
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
                                    color: Colors.black),
                              ),
                            ),
                            PopularTopics(),
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 20.0, top: 20.0, bottom: 10.0),
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
                        ))
                  ],
                ),
              )),
        );
      },
    );
  }
}
