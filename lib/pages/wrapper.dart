import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/pages/authentication/authenticate.dart';
import 'package:flutter_interview_preparation/pages/home_container.dart';
import 'package:flutter_interview_preparation/pages/test/profile.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);
    return user != null ? HomeContainerWidget() : Authenticate();
  }
}
