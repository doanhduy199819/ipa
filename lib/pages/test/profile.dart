import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(),
        Avatar(),
        CustomColumn(
            image_path: "assets/images/icons_myaccount.png",
            content: "My account"),
        CustomColumn(
            image_path: "assets/images/icons_notifications.png",
            content: "Notifications"),
        CustomColumn(
            image_path: "assets/images/icons_setting.png", content: "Settings"),
        CustomColumn(
            image_path: "assets/images/icons_help.png", content: "Help Center"),
        CustomColumn(
            image_path: "assets/images/icons_logout.png", content: "Log Out"),
      ],
    );
  }
}

class CustomColumn extends StatelessWidget {
  const CustomColumn({
    Key? key,
    required this.image_path,
    required this.content,
  }) : super(key: key);

  final String image_path;
  final String content;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFFCFD8DC),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(children: [
          Image(
              height: 30, image: AssetImage(image_path), fit: BoxFit.fitHeight),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(content,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                )),
          ),
          Spacer(),
          Image(
              height: 20,
              image: AssetImage("assets/images/icons_forward.png"),
              fit: BoxFit.fitHeight)
        ]),
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 50, right: 50, top: 50, bottom: 50),
        alignment: Alignment.center,
        height: 140,
        width: 140,
        child: Stack(
          children: [
            const CircleAvatar(
                backgroundColor: Colors.yellowAccent,
                radius: 80,
                backgroundImage: AssetImage("assets/images/dog.jpg")),
            Container(
                alignment: Alignment.bottomRight,
                child: const CircleAvatar(
                  backgroundColor: Color(0xFFCFD8DC),
                  radius: 25,
                  child: Image(
                      height: 25,
                      width: 25,
                      image: AssetImage("assets/images/icons_add_camera.png"),
                      fit: BoxFit.fitHeight),
                ))
          ],
        ));
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50,
          width: 70,
          child: const Icon(Icons.arrow_back_ios),
        ),
        const Spacer(),
        const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        const Spacer(),
        Container(height: 50, width: 70)
      ],
    );
  }
}
