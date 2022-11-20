import 'package:flutter/material.dart';

class CustomBox extends StatelessWidget {
  CustomBox(
      {Key? key,
      required this.height,
      required this.width,
      required this.color})
      : super(key: key);

  final double height;
  final double width;
  final List<Color> color;

  Widget CustomGrander() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: <Color>[
              color[0].withOpacity(0.5),
              color[1].withOpacity(0.5)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: color[2],
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: color[3].withOpacity(0.2),
                blurRadius: 15.0,
                spreadRadius: 5.0,
              )
            ]),
        child: Stack(
          children: [
            WavyHeader(
              color: color[3],
            ),
            CustomCircle(color: color[3]),
            CustomGrander(),
          ],
        ));
  }
}

class WavyHeader extends StatelessWidget {
  const WavyHeader({Key? key, required this.color}) : super(key: key);

  final Color color;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: TopWaveClipper(),
        child: Container(
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    colors: <Color>[Colors.white.withOpacity(0.1), color],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft))));
  }
}

class TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(size.width * 0.3, 0);

    var firstControlPoint = new Offset(size.width * 0.4, size.height * 0.2);
    var firstEndPoint = new Offset(size.width * 0.6, size.height * 0.15);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = new Offset(size.width * 0.8, size.height * 0.15);
    var secondEndPoint = new Offset(size.width * 0.85, size.height * 0.4);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    var thirdControlPoint = new Offset(size.width * 0.85, size.height * 0.5);
    var thirdEndPoint = new Offset(size.width, size.height * 0.5);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CustomCircle extends StatelessWidget {
  const CustomCircle({Key? key, required this.color}) : super(key: key);

  final Color color;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: Circle(),
        child: Container(
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // color: color,
                gradient: LinearGradient(
                    colors: <Color>[Colors.white.withOpacity(0.1), color],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight))));
  }
}

class Circle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.addOval(Rect.fromCircle(
      center: Offset(size.width * 0.1, size.height * 1.1),
      radius: size.width * 0.5,
    ));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
