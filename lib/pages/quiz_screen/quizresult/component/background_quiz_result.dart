import 'package:flutter/material.dart';

class BackgroundQuizResult extends StatelessWidget {
  const BackgroundQuizResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      WavyHeader(
        color: Colors.white.withOpacity(0.2),
        circle: Circle(
            offSet: Offset(size.width / 2, size.height / 4),
            radius: size.width / 5 + 30),
      ),
      WavyHeader(
        color: Colors.white.withOpacity(0.5),
        circle: Circle(
            offSet: Offset(size.width / 2, size.height / 4),
            radius: size.width / 5 + 10),
      ),
      WavyHeader(
        color: Colors.white,
        circle: Circle(
            offSet: Offset(size.width / 2, size.height / 4),
            radius: size.width / 5),
      ),
      WavyHeader(
        color: Colors.white.withOpacity(0.1),
        circle: Circle(
            offSet: Offset(size.width * 0.8, size.height * 0.1), radius: 25),
      ),
      WavyHeader(
        color: Colors.white.withOpacity(0.1),
        circle: Circle(offSet: Offset(size.width / 2, 0), radius: 50),
      ),
      WavyHeader(
        color: Colors.white.withOpacity(0.1),
        circle: Circle(offSet: Offset(0, size.height * 0.1), radius: 80),
      ),
      WavyHeader(
        color: Colors.white.withOpacity(0.1),
        circle:
            Circle(offSet: Offset(size.width, size.height * 0.4), radius: 80),
      ),
    ]);
  }
}

class WavyHeader extends StatelessWidget {
  const WavyHeader({Key? key, required this.color, required this.circle})
      : super(key: key);
  final CustomClipper<Path> circle;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: circle,
        child: Container(
          decoration: BoxDecoration(
            color: color,
          ),
        ));
  }
}

class Circle extends CustomClipper<Path> {
  const Circle({required this.offSet, required this.radius});

  final Offset offSet;
  final double radius;

  @override
  Path getClip(Size size) {
    var path = Path();

    path.addOval(Rect.fromCircle(
      center: offSet,
      radius: radius,
    ));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
