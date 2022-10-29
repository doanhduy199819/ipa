import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key, required this.data}) : super(key: key);

  final Map data;

  List<Widget> loadData() {
    List<Widget> child = [CustomAppBar(), Avatar()];
    data.forEach(((key, value) {
      child.add(CustomColumn(title: key, subtitle: value));
    }));
    return child;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: loadData(),
    );
  }
}

class CustomColumn extends StatelessWidget {
  const CustomColumn({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title + ': ',
          style: TextStyle(fontSize: 20),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          width: MediaQuery.of(context).size.width - 100,
          height: 50,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 217, 219, 226),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            subtitle,
            // textAlign: Alignment.centerLeft,
            style: TextStyle(fontSize: 18),
          ),
        )
      ],
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
