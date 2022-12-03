import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/FirestoreUser.dart';
import 'package:flutter_interview_preparation/objects/UserProfile.dart';
import 'package:flutter_interview_preparation/pages/components/birthday_menu_box.dart';
import 'package:flutter_interview_preparation/pages/components/gender_menu_box.dart';
import 'package:flutter_interview_preparation/pages/components/name_menu_box.dart';
import 'package:flutter_interview_preparation/pages/profile_screen/change_password_page.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
import 'package:provider/provider.dart';

import '../../values/Home_Screen_Fonts.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);
  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late double hei;
  late double wid;
  late bool followCheck;
  late TextEditingController controller;
  late FirestoreUser? userData;
  void initData() {
    followCheck = false;
  }

  final Stream<FirestoreUser?> _stream = DatabaseService().userData;

  @override
  void initState() {
    // TODO: implement initState
    controller = TextEditingController();
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    hei = MediaQuery.of(context).size.height;
    wid = MediaQuery.of(context).size.width;

    return StreamProvider.value(
      value: _stream,
      initialData: null,
      builder: (context, snapshot) {
        userData = Provider.of<FirestoreUser?>(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Account', style: HomeScreenFonts.headStyle),
          ),
          body: ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildTop(),
              _buildBody(userData?.displayName ?? '',
                  AuthService().currentUser?.email ?? ''),
            ],
          ),
        );
      },
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
          top: hei * 0.2,
          child: _buildUserImage(),
        )
      ],
    );
  }

  Widget _buildBody(String name, String email) {
    return Column(
      children: [
        // _buildButtonFollow(),
        NameBoxWidget(
          userName: name,
          context: context,
        ),
        EmailBoxWidget(
          string: email,
        ),
        _buildChangePassword(),
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
        image: const AssetImage("assets/images/bg_profile.png"),
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
            const SizedBox(
              width: 20,
            ),
            Text(string),
            const Spacer(),
            InkWell(
              child: Icon(
                Icons.edit,
                size: 16,
                color: Colors.grey,
              ),
              onTap: (() => _buildEdit(string)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChangePassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: InkWell(
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          InkWell(
            child: Text(
              'Change password',
              style: TextStyle(
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey),
            ),
            onTap: (() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChangePassword()));
            }),
          ),
        ]),
      ),
    );
  }

  Future _buildEdit(String str) => showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel')),
            TextButton(
                onPressed: () {
                  //upload date len firebase
                  Navigator.of(context).pop();
                },
                child: Text('Edit'))
          ],
          title: Text('Edit information'),
          content: Container(
            height: hei * 0.1,
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: "$str",
                  ),
                  controller: controller,
                ),
              ],
            ),
          ),
        );
      }));
  Future<DateTime?> pickDay() => showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000, 1, 1),
      lastDate: DateTime.now());
  String _getStringBirthday(DateTime dt) {
    return dt.day.toString() +
        '/' +
        dt.month.toString() +
        '/' +
        dt.year.toString();
  }
}
