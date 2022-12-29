import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';

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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(AuthService().currentUser?.isAnonymous ==true){
          return;
        }
        (onActiveChange != null) ? onActiveChange!(isActive) : null;
      },
      child: isActive ? activeIcon : unActiveIcon,
    );
  }
}
