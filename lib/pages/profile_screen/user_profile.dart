import 'package:flutter/material.dart';

import '../../values/Home_Screen_Fonts.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late double hei;
  late double wid;
  late bool followCheck;
  void initData() {
    followCheck = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    hei = MediaQuery.of(context).size.height;
    wid = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Account', style: HomeScreenFonts.headStyle),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildTop(),
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildTop() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
            margin: EdgeInsets.only(bottom: hei * 0.1 + 4),
            child: _buildCoverImage()),
        Positioned(
          child: _buildUserImage(),
          top: hei * 0.2,
        )
      ],
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        // _buildButtonFollow(),
        _buildGroup(Icons.person, 'Lê Hoàng Vỹ'),
        _buildGroup(Icons.calendar_month, '21/05/2001'),
        _buildGroup(Icons.mail, 'lehoangvy2105@gmail.com'),
        _buildGroup(Icons.people, 'Male'),
        _buildQuestion()
      ],
    );
  }

  Widget _buildUserImage() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 4,
        ),
        borderRadius: BorderRadius.circular(100),
      ),
      child: CircleAvatar(
          radius: hei * 0.1,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage("assets/images/avatar.png")),
    );
  }

  Widget _buildCoverImage() {
    return Container(
      color: Colors.lightBlue,
      child: Image(
        image: AssetImage("assets/images/bg_profile.png"),
        height: hei * 0.3,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildGroup(IconData icon, String string) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
            width: 1,
            color: Colors.grey,
          ))),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: (() {}),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(
              width: 20,
            ),
            Text(string),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestion() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          children: [
            Text(
              'Your Question ',
              style: HomeScreenFonts.title,
            ),
            //_buildListYourQuestion(),
          ],
        ),
      ),
    ]);
  }

  Widget _buildListYourQuestion() {
    return ListView(
      children: [],
    );
  }

  // Widget _buildButtonFollow() {
  //   return Container(
  //     margin: EdgeInsets.only(top: hei * 0.075, left: hei * 0.2),
  //     child: InkWell(
  //       onTap: () {
  //         setState(() {
  //           followCheck = !followCheck;
  //         });
  //       },
  //       child: followCheck == true
  //           ? Container(
  //               padding:
  //                   const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
  //               decoration: BoxDecoration(
  //                 color: Colors.blue.shade300,
  //                 borderRadius: BorderRadius.circular(30),
  //                 border: Border.all(
  //                   color: Colors.white,
  //                   width: 2,
  //                 ),
  //               ),
  //               child: Text(
  //                 'Following',
  //                 style: HomeScreenFonts.description,
  //               ),
  //             )
  //           : Container(
  //               padding:
  //                   const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
  //               decoration: BoxDecoration(
  //                 color: Colors.grey.shade300,
  //                 borderRadius: BorderRadius.circular(30),
  //                 border: Border.all(
  //                   color: Colors.white,
  //                   width: 2,
  //                 ),
  //               ),
  //               child: Text(
  //                 'Follow',
  //                 style: HomeScreenFonts.description,
  //               ),
  //             ),
  //     ),
  //   );
  // }
}
