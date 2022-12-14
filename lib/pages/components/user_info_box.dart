import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserInfoBox extends StatelessWidget {
  const UserInfoBox({
    Key? key,
    this.photoUrl,
    this.userName,
    this.postFix,
    this.avatarRadius = 12,
    this.fontSize,
  }) : super(key: key);

  final String? photoUrl;
  final String? userName;
  final Widget? postFix;
  final double? avatarRadius;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    const samplephotoUrl =
        'https://w0.peakpx.com/wallpaper/871/154/HD-wallpaper-pikachu-amoled-iphone-pokemon-samsung.jpg';
    const sampleUserName = 'Pikachu';
    var titleTextStyle = TextStyle(
        fontWeight: FontWeight.bold, fontSize: fontSize ?? avatarRadius);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
          child: CircleAvatar(
            radius: avatarRadius,
            // backgroundImage: NetworkImage(photoUrl ?? samplephotoUrl),
            backgroundImage: CachedNetworkImageProvider(
              photoUrl ?? samplephotoUrl,
            ),
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
