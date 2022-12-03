import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/objects/FirestoreUser.dart';
import 'package:flutter_interview_preparation/pages/profile_screen/user_profile.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:flutter_interview_preparation/pages/profile_screen/saved_articles.dart';
import 'package:flutter_interview_preparation/pages/profile_screen/saved_qa.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
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
  final Stream<FirestoreUser?> _stream = DatabaseService().userData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirestoreUser?>.value(
        value: _stream,
        initialData: null,
        builder: (context, snapshot) {
          User? userAuth = Provider.of<User?>(context);
          FirestoreUser? userData = Provider.of<FirestoreUser?>(context);
          debugPrint(userData?.savedArticles.toString());

          userName = userAuth?.displayName;
          userEmail = userAuth?.email;
          userAvatarUrl = userAuth?.photoURL ?? "assets/images/avatar.png";

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
                          title: Text('Saved articles'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SavedArticle(),
                                  fullscreenDialog: false,
                                  settings: RouteSettings(
                                    arguments: userData,
                                  ),
                                ));
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
                                builder: (context) => const SavedQuestion(),
                                settings: RouteSettings(
                                  arguments: userData,
                                ),
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
                                  builder: (context) => const UserProfilePage(),
                                  settings: RouteSettings(
                                    arguments: userData,
                                  ),
                                ));
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
                        child: const ListTile(
                          // TODO: FOLLWING USERS

                          leading: Icon(Icons.supervised_user_circle),
                          title: Text('Following Users'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            AuthService().signOut();
                          },
                          child: const Text('Log out'),
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
