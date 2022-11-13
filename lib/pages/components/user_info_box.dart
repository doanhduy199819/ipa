import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserInfoBox extends StatelessWidget {
  const UserInfoBox({
    Key? key,
    this.photoUrl,
    this.userName,
    this.postFix,
    this.fontSize = 12,
  }) : super(key: key);

  final String? photoUrl;
  final String? userName;
  final Widget? postFix;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    const samplephotoUrl =
        'https://w0.peakpx.com/wallpaper/871/154/HD-wallpaper-pikachu-amoled-iphone-pokemon-samsung.jpg';
    const sampleUserName = 'Pikachu';
    var titleTextStyle =
        TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
          child: CircleAvatar(
            radius: fontSize,
            backgroundImage: NetworkImage(photoUrl ?? samplephotoUrl),
          ),
        ),
        Text(
          userName ?? sampleUserName,
          style: titleTextStyle,
        ),
        if (postFix != null)
          Expanded(
            child: Align(alignment: Alignment.centerRight, child: postFix),
          ),
      ],
    );
  }
}
