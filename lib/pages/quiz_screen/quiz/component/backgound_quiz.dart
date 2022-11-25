import 'package:flutter/material.dart';

class BackgroundQuiz extends StatelessWidget {
  const BackgroundQuiz(
      {Key? key, required this.body, required this.circleHeader})
      : super(key: key);
  final Color body;
  final Color circleHeader;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: body,
      child: WavyHeader(color: circleHeader),
    );
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
              gradient: LinearGradient(
                  colors: <Color>[color, color],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
        ));
  }
}

class TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height * 0.4);

    var firstControlPoint = new Offset(size.width / 2, size.height / 2);
    var firstEndPoint = new Offset(size.width, size.height * 0.4);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
