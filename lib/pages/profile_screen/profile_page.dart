import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/pages/profile_screen/user_profile.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:flutter_interview_preparation/pages/profile_screen/saved_articles.dart';
import 'package:flutter_interview_preparation/pages/profile_screen/saved_qa.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String? userName;
  late String? userEmail;
  late String? userAvatarUrl;

  String backgroundImageurl = "assets/images/bg_profile.png";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
        value: FirebaseAuth.instance.userChanges(),
        initialData: null,
        builder: (context, snapshot) {
          User? user = Provider.of<User?>(context);
          userName = user?.displayName;
          userEmail = user?.email;
          userAvatarUrl = user?.photoURL ?? "assets/images/avatar.png";
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            body: SafeArea(
              child: ListView(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(userName ?? 'No name'),
                    accountEmail: Text(userEmail ?? 'No email'),
                    currentAccountPicture: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                              userAvatarUrl ?? "assets/images/avatar.png"),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(backgroundImageurl),
                            fit: BoxFit.cover)),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 2),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 1,
                                offset: Offset(0.0, 3),
                                color: Colors.grey,
                              ),
                            ]),
                        child: ListTile(
                          leading: Icon(Icons.article),
                          title: Text('Saved article'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SavedArticle(),
                                fullscreenDialog: false,
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 2),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              offset: Offset(0.0, 3),
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: Icon(Icons.question_mark),
                          title: Text('Saved questions'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    fullscreenDialog: false,
                                    builder: (context) => SavedQuestion()));
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 2),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              offset: Offset(0.0, 3),
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: Icon(Icons.interests),
                          title: Text('Interests'),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 2),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              offset: Offset(0.0, 3),
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: Icon(Icons.account_circle),
                          title: Text('Accounts'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    fullscreenDialog: false,
                                    builder: (context) => UserProfilePage()));
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 2),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              offset: Offset(0.0, 3),
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: Icon(Icons.supervised_user_circle),
                          title: Text('Following User'),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextButton(
                          onPressed: () => AuthService().signOut(),
                          child: Text('Log out'),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
