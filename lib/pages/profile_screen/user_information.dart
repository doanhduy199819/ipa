import 'package:flutter/material.dart';

import '../../values/Home_Screen_Fonts.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Account',
            style: HomeScreenFonts.h1.copyWith(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
      body: Body(),
    );
  }
}

Widget Body() {
  return Column(
    children: [
      SizedBox(
        width: 115,
        height: 115,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/avatar.png"),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: SizedBox(
                width: 30,
                height: 30,
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  color: Colors.grey,
                  child: Icon(Icons.camera_enhance),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
            )
          ],
        ),
      ),
      Menu(),
    ],
  );
}

Widget Menu() {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        margin: EdgeInsets.all(5),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: (() {}),
          child: Row(
            children: [
              Icon(Icons.person),
              SizedBox(
                width: 20,
              ),
              Text('Le Hoang Vy'),
            ],
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              Icon(Icons.calendar_month),
              SizedBox(
                width: 20,
              ),
              Text('21/05/2001'),
            ],
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: InkWell(
          onTap: (() {}),
          child: Row(
            children: [
              Icon(Icons.mail),
              SizedBox(
                width: 20,
              ),
              Text('lehoangvy2105@gmail.com')
            ],
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: InkWell(
          onTap: (() {}),
          child: Row(
            children: [
              Icon(Icons.people),
              SizedBox(
                width: 20,
              ),
              Text('Male')
            ],
          ),
        ),
      )
    ],
  );
}
