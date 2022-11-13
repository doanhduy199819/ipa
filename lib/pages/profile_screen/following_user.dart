import 'package:flutter/material.dart';

class FollowUser {
  String? imagePath;
  String? userName;
  String? fullName;
  FollowUser(this.imagePath, this.fullName, this.userName);
}

List<FollowUser> listFollowUser = [
  FollowUser("assets/images/avatar.png", "Trong Huy", "handsome"),
  FollowUser("assets/images/avatar.png", "Hoang Vy", "hoangvy2105"),
  FollowUser("assets/images/avatar.png", "Anh Duy", "doanhduy"),
  FollowUser("assets/images/avatar.png", "Nhat Tan", "iamtan"),
  FollowUser("assets/images/avatar.png", "Thu Hien", "btthuhien"),
];

class FollowingUser extends StatefulWidget {
  const FollowingUser({super.key});

  @override
  State<FollowingUser> createState() => _FollowingUserState();
}

class _FollowingUserState extends State<FollowingUser> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.separated(
      itemCount: listFollowUser.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 70,
          child: FollowUserBox(user: listFollowUser[index]),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

class FollowUserBox extends StatelessWidget {
  const FollowUserBox({
    super.key,
    required this.user,
  });

  final FollowUser user;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 70,
      width: size.width - 40,
      margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(user.imagePath.toString()),
                    fit: BoxFit.scaleDown)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.fullName.toString(),
                style: TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontSize: 18,
                ),
              ),
              Text(
                "@" + user.userName.toString(),
                style: TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(right: 10),
            height: 40,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 1.0, color: Color.fromRGBO(58, 182, 255, 1)),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Text("Following",
                  style: TextStyle(
                    color: Color.fromRGBO(58, 182, 255, 1),
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                  )),
            ),
          ),
          Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/icons/icon_3cham.png"),
                    fit: BoxFit.scaleDown)),
          )
        ],
      ),
    );
  }
}
