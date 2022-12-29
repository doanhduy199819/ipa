import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../objects/UserBlocked.dart';
import '../../services/auth_service.dart';

class InterractionIcon extends StatelessWidget {
   InterractionIcon(
      {Key? key,
      // this.activeIconData = Icons.arrow_upward_rounded,
      this.onTap,
      this.label,
      // this.activeColor = Colors.green,
      // this.unActiveColor = Colors.grey,
      this.isActive = false,
      this.onActiveChange,
      this.hasBackgroundDecoration = true,
      // this.size = 12.0,
      this.activeIcon,
      this.unActiveIcon,
      this.activeBackgroundColor = Colors.green,
      this.unActiveBackgroundColor = Colors.grey})
      : super(key: key);

  final Icon? activeIcon;
  final Icon? unActiveIcon;
  final String? label;
  final bool isActive;
  final bool hasBackgroundDecoration;
  final Color activeBackgroundColor;
  final Color unActiveBackgroundColor;
  final void Function()? onTap;
  final void Function(bool)? onActiveChange;

    late Future<List<UserBlocked>?> _userBlockedFuture;


    List<UserBlocked>? _userBlockedsFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    return querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        print('exits');
        return UserBlocked.fromDocumentSnapshot(documentSnapshot);
      }
      return UserBlocked.test();
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore _db = FirebaseFirestore.instance;

    _userBlockedFuture = _db
        .collection('userwasblocked')
        .get()
        .then(_userBlockedsFromQuerySnapshot);
    return InkWell(
      onTap: () async {
        if(AuthService().currentUser?.isAnonymous ==true){
          return;
        }
        print('====USER UID GG ${AuthService().currentUser!.uid}');
        var usersblocked = await _userBlockedFuture;
        for(int i=0;i<usersblocked!.length;i++){
          print('====USER UID MINE ${usersblocked[i].id_user}');
          if(usersblocked[i].id_user==AuthService().currentUser!.uid){
            return;
          }
        }

        (onActiveChange != null) ? onActiveChange!(isActive) : null;
      },
      child: Container(
        decoration: hasBackgroundDecoration
            ? BoxDecoration(
                color:
                    isActive ? activeBackgroundColor : unActiveBackgroundColor,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(width: 0.5, color: Colors.grey),
              )
            : null,
        padding: const EdgeInsets.all(4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.zero,
              child: isActive ? activeIcon : unActiveIcon,
            ),
            if (label != null)
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  label!.toString(),
                  style: isActive
                      ? TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)
                      : null,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
