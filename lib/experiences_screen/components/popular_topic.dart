import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../objects/Comment.dart';
import '../../../objects/Topic.dart';
import '../../../services/database_service.dart';
import '../../../objects/ExperiencePost.dart';
import 'package:flutter_interview_preparation/objects/ExperiencePost.dart';

import '../screens/post_of_topic.dart';

class PopularTopics extends StatefulWidget {
  PopularTopics({Key? key}) : super(key: key);

  @override
  State<PopularTopics> createState() => _PopularTopicsState();
}

class _PopularTopicsState extends State<PopularTopics> {
  late List<ExperiencePost> _post;
  late List<Topic> _topic;
  List<Color> colors = [
    Colors.purple,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.redAccent
  ];
  List<Color> colors1 = const [
    Color.fromARGB(255, 214, 125, 230),
    Color.fromARGB(255, 114, 159, 236),
    Color.fromARGB(255, 158, 238, 199),
    Color.fromARGB(255, 241, 165, 165)
  ];


  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    _post=[];
    _topic=[];
  }

  String getNumberOfPostTopic(String id)
  {
    int count=0;
    for(int i=0;i<_post.length;i++)
      {
        if(_post[i].topic_id!.compareTo(id)==0)
          count++;
      }
    return count.toString();
  }

  Container buildTag()
  {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _topic.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => PostOfTopic(idTopic: _topic[index].idTopic, name: _topic[index].topic_name!) ));
            },
            child: Container(
              //padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.only(left: 20.0),
              width: 170,
              decoration: BoxDecoration(
                color: colors[index%4],
                gradient: LinearGradient(colors: <Color>[
                  colors[index % colors.length],
                  colors1[index % colors.length],
                ], begin: Alignment.centerRight, end: Alignment.centerLeft),
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: Stack(
                children: [
                  WavyHeader(
                    TopWaveClipper: TopWaveClipper2(),
                    color: Colors.white.withOpacity(0.2),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _topic[index].topic_name!,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          getNumberOfPostTopic(_topic[index].idTopic)+" posts",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              letterSpacing: 0.7),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );

        },
      ),
    );
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

        return FutureBuilder(
          future: DatabaseService().allTopicOnce,
          builder:
              (BuildContext context, AsyncSnapshot<List<Topic>?> snapshot) {
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
            _topic = snapshot.data! as List<Topic>;

              return buildTag();

          },
        );

      },
    );

  }


}



class WavyHeader extends StatelessWidget {
  const WavyHeader(
      {Key? key, required this.TopWaveClipper, required this.color})
      : super(key: key);

  final CustomClipper<Path> TopWaveClipper;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: TopWaveClipper,
        child: Container(
          width: MediaQuery.of(context).size.width/ 2.5,
          height: MediaQuery.of(context).size.height / 2.5,
          decoration: BoxDecoration(
            color: color,
          ),
        ));
  }
}


class TopWaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width * 1, size.height * 0.15*(-1));
    path.lineTo(size.width * 1, size.height * 0.35*(-1));
    path.lineTo(size.width * 0.25*(-1), size.height * 0.35*(-1));
    path.quadraticBezierTo(size.width * 0.26*(-1), size.height * 0.348*(-1), size.width * 0.27*(-1), size.height * 0.345*(-1));
    path.lineTo(size.width * 0.27*(-1), size.height * 1);
    path.lineTo(size.width * 0.175, size.height * 1);
    path.quadraticBezierTo(size.width * 1,  size.height * 1, size.width * 1, size.height * 0.15*(-1));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
