import 'package:flutter/material.dart';
import '../component/custom_box.dart';
import '../object/categories.dart';

class CustomBoxCategories extends StatelessWidget {
  CustomBoxCategories(
      {Key? key,
      required this.height,
      required this.width,
      required this.color,
      required this.categories})
      : super(key: key);

  final double height;
  final double width;
  final List<Color> color;
  final Categories categories;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            CustomBox(height: height, width: width, color: color),
            Container(
              height: 165 * 0.7,
              margin: EdgeInsets.only(
                  left: 16.5, right: 16.5, top: 10, bottom: 165 * 0.3),
              child: Column(
                children: [
                  Spacer(),
                  Container(
                      child: Align(
                    alignment: Alignment.center,
                    child: Text(categories.specialized,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 28,
                            fontFamily: "RobotoSlab")),
                  )),
                  Container(
                    child: Align(
                      // alignment: Alignment.topLeft,
                      child: Text(categories.name,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 12,
                            fontWeight: FontWeight.w200,
                          )),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            )
          ],
        ));
  }
}
