import 'package:flutter/material.dart';

class BackgroundQuizDiscription extends StatelessWidget {
  const BackgroundQuizDiscription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 0.25,
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(145, 171, 217, 1),
                blurRadius: 15.0,
                spreadRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30)),
            gradient: LinearGradient(colors: <Color>[
              Color.fromRGBO(165, 204, 255, 1),
              Color.fromRGBO(115, 104, 226, 1)
            ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
        child: Stack(children: [
          WavyHeader(
            TopWaveClipper: TopWaveClipper1(),
            linearGradient: LinearGradient(colors: <Color>[
              Colors.white.withOpacity(0.15),
              Colors.white.withOpacity(0)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          WavyHeader(
            TopWaveClipper: TopWaveClipper2(),
            linearGradient: LinearGradient(colors: <Color>[
              Colors.white.withOpacity(0.2),
              Colors.white.withOpacity(0)
            ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          ),
          WavyHeader(
              TopWaveClipper: TopWaveClipper3(),
              linearGradient: LinearGradient(colors: <Color>[
                Colors.blueAccent.withOpacity(0.4),
                Color.fromRGBO(115, 104, 226, 0.7)
              ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
        ]));
  }
}

class WavyHeader extends StatelessWidget {
  const WavyHeader(
      {Key? key, required this.TopWaveClipper, required this.linearGradient})
      : super(key: key);

  final CustomClipper<Path> TopWaveClipper;
  final LinearGradient linearGradient;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: TopWaveClipper,
        child: Container(
          height: MediaQuery.of(context).size.height / 2.5,
          decoration: BoxDecoration(gradient: linearGradient),
        ));
  }
}

class TopWaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height * 0.4);
    path.lineTo(size.width * 0.35, size.height * 0.3);
    path.lineTo(size.width * 0.2, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TopWaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width * 0.8, 0);
    path.lineTo(size.width * 0.85, size.height * 0.35);
    path.lineTo(size.width, size.height * 0.2);
    path.lineTo(size.width, 0);
    path.lineTo(size.width * 0.7, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TopWaveClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width * 0.5, size.height * 0.5);
    path.lineTo(size.width * 0.7, size.height * 0.6);
    path.lineTo(size.width * 0.65, size.height * 0.3);

    path.lineTo(size.width * 0.5, size.height * 0.5);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
