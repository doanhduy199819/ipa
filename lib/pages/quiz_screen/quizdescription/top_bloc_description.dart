import 'package:flutter/material.dart';

import 'component/circle_avatar.dart';

class TopBlocDescription extends StatelessWidget {
  const TopBlocDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Trong Huy',
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
  }
}
