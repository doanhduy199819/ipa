import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/ExperiencePost.dart';

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

  void _initSampleData(){
    _post=ExperiencePost.getSampleExperiencePostList();
  }

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
        if (snapshot.hasError) {
          return Text('Something went wrong :(');
        }
        if (snapshot.data == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: [
              CircularProgressIndicator(),
            ],
          );
        }
        _post = snapshot.data! as List<ExperiencePost>;
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