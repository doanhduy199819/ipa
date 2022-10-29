import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/pages/home_container.dart';
import 'package:flutter_interview_preparation/pages/home_screen/homepage.dart';
import 'package:flutter_interview_preparation/pages/interest_screen/Interest_Page.dart';
import 'package:flutter_interview_preparation/pages/profile_screen/profile_page.dart';
import 'package:flutter_interview_preparation/pages/quizz_screen/quizz_page.dart';
import 'package:flutter_interview_preparation/pages/search_screen/search_page.dart';
import 'package:flutter_interview_preparation/pages/test/profile.dart';
import 'package:flutter_interview_preparation/pages/wrapper.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    // home: InterestWidget(),
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return StreamProvider<User?>.value(
    //   value: AuthService().user,
    //   initialData: null,
    //   child: MaterialApp(
    //     title: 'IPA',
    //     theme: ThemeData(
    //       primarySwatch: Colors.blue,
    //     ),
    //     // home: const HomeContainerWidget(),
    //     home: Wrapper(),
    //     debugShowCheckedModeBanner: false,
    //   ),
    // );
    return Scaffold(
      body: Profile(),
    );
  }
}
