import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Interest.dart';

import '../../values/Interest_Screen_Fonts.dart';

class CustomInterestBloc extends StatelessWidget{
  final bool isClicked;
  final Interest interest;
  final double widthOfDevice;
  final VoidCallback onTap;

  // ignore: use_key_in_widget_constructors
  const CustomInterestBloc({
    required this.isClicked,
    required this.interest,
    required this.widthOfDevice,
    required this.onTap,
  });

  
   @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: (isClicked ==false) ?Colors.white : const Color(0xff2041F4),
              borderRadius: BorderRadius.circular(50),
            ),
            alignment: Alignment.center,
            width: widthOfDevice*35/100,
            height: widthOfDevice*14/100,
            child: Text('${interest.title}',style: InterestFont.fontInterestBloc,),
          ),
          const SizedBox(height: 20,)
        ],
      ),
    );
  }
}