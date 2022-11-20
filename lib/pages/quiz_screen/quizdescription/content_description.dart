import 'package:flutter/material.dart';
class ContentDescriptionWidget extends StatelessWidget {
  double widthOfDevice;
  List<String> contentDescription;
  ContentDescriptionWidget({Key? key , required this.widthOfDevice, required this.contentDescription}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(245, 241, 255, 1),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      width: widthOfDevice - 40,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...(contentDescription.map((e) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                e,
                style: const TextStyle(
                    //fontFamily: 'Nunito',
                    ),
              ),
            );
          }).toList()),
        ],
      ),
    );
  }
}
