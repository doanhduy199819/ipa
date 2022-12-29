import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../objects/UserBlocked.dart';

class LikeIcon extends StatelessWidget {
  LikeIcon({
    Key? key,
    required this.activeIcon,
    required this.unActiveIcon,
    required this.isActive,
    this.onTap,
    required this.onActiveChange,
  }) : super(key: key);

  final Icon? activeIcon;
  final Icon? unActiveIcon;
  final bool isActive;
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
        var usersblocked = await _userBlockedFuture;
        for(int i=0;i<usersblocked!.length;i++){
          if(usersblocked[i].id_user==AuthService().currentUser!.uid){
            return;
          }
        }
        (onActiveChange != null) ? onActiveChange!(isActive) : null;
      },
      child: isActive ? activeIcon : unActiveIcon,
    );
  }
}
