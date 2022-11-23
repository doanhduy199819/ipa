import 'package:flutter/material.dart';

class background extends StatelessWidget {
  const background(
      {Key? key, required this.color, required this.havenavigationbar})
      : super(key: key);
  final int havenavigationbar;
  final List<Color> color;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        color: color[2],
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          WavyHeader(color: color),
          Circle(color: color[3]),
          Column(
            children: [
              Container(height: size.height * 0.20),
              Container(
                height: size.height * 0.80 - havenavigationbar * 57,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(15, 20, 60, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(61, 47, 116, 0.8),
                        blurRadius: 15.0,
                        spreadRadius: 5.0,
                      )
                    ]),
              )
            ],
          )
        ]));
  }
}

class WavyHeader extends StatelessWidget {
  const WavyHeader({Key? key, required this.color}) : super(key: key);

  final List<Color> color;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: TopWaveClipper(),
        child: Container(
          height: MediaQuery.of(context).size.height / 2.5,
          decoration: BoxDecoration(
              // color: Color.fromRGBO(255, 255, 255, 0.12),
              gradient: LinearGradient(
                  colors: <Color>[color[3], color[2]],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
        ));
  }
}

class TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height / 2 + 10);

    var firstControlPoint = new Offset(size.width / 5, size.height / 2 - 10);
    var firstEndPoint = new Offset(size.width / 5, size.height / 4);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = new Offset(size.width / 5, size.height / 8);
    var secondEndPoint = new Offset(size.width / 3, 0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class Circle extends StatelessWidget {
  const Circle({Key? key, required this.color}) : super(key: key);

  final Color color;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Transform.translate(
        offset: Offset(size.width * 4 / 6, size.height / 8),
        child: Material(
          color: this.color,
          child: Padding(padding: EdgeInsets.all(80)),
          shape: CircleBorder(
            side: BorderSide(color: this.color),
          ),
        ));
  }
}
