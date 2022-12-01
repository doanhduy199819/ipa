import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Helper.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';

import 'component/circle_avatar.dart';

class TopBlocDescription extends StatelessWidget {
  const TopBlocDescription({Key? key}) : super(key: key);

  Future<String?> loadData() async {
    if (await DatabaseService().checkUserExits() == false) return "Incognito";
    return AuthService().currentUser?.displayName.toString();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadData(),
        builder: (context, AsyncSnapshot<String?> snapshot) {
          return Helper().handleSnapshot(snapshot) ??
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Spacer(),
                      // Avatar Circle
                      const CircleAvatarWidget(),
                      //Name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              snapshot.data.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              );
        });
  }
}
