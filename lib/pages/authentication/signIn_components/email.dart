import 'package:flutter/material.dart';

class buildEmail extends StatelessWidget {
  const buildEmail({
    Key? key,
    required this.mainColor,
    this.onChanged,
  }) : super(key: key);

  final Color mainColor;
  final Function(String?)? onChanged;
  final Icon icon = const Icon(Icons.email_rounded, color: Colors.blue);
  final String hintText = 'Email';
  final boxDecoration = const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0),
      padding: EdgeInsets.only(left: 16.0, right: 8.0),
      decoration: boxDecoration,
      child: Row(
        children: [
          icon,
          const SizedBox(
            width: 8.0,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16.0),
                  hintStyle: TextStyle(color: Colors.grey)),
              style: TextStyle(color: Colors.black),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
