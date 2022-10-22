import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProfilePage'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app_outlined),
            onPressed: () {
              AuthService _auth = AuthService();
              _auth.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Profile Screen',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
