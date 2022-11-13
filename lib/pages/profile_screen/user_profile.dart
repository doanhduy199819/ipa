import 'package:flutter/material.dart';

import '../../values/Home_Screen_Fonts.dart';

class UserProfile extends StatelessWidget {
  late double hei;
  late double wid;
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
            margin: EdgeInsets.only(bottom: hei * 0.1),
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
        _buildGroup(Icons.person, 'Lê Hoàng Vỹ'),
        _buildGroup(Icons.calendar_month, '21/05/2001'),
        _buildGroup(Icons.mail, 'lehoangvy2105@gmail.com'),
        _buildGroup(Icons.people, 'Male'),
        _buildArticle(),
        _buildQuestion()
      ],
    );
  }

  Widget _buildUserImage() => CircleAvatar(
        radius: hei * 0.1,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: AssetImage("assets/images/avatar.png"),
      );

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

  Widget _buildArticle() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Text(
            'Your Articles ',
            style: HomeScreenFonts.title,
          ),
          Text(' '),
        ],
      ),
    );
  }

  Widget _buildQuestion() {
    return Container(
      child: Column(
        children: [
          Text(
            'Your Question ',
            style: HomeScreenFonts.title,
          ),
          Text(' '),
        ],
      ),
    );
  }
}
