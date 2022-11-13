
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Assets.dart';
import 'package:intl/intl.dart';
class CompanyBloc extends StatelessWidget {
  String? idCompany;
  DateTime? timePosted;
  String? urlImage;
   CompanyBloc({Key? key,required this.idCompany, required this.timePosted , this.urlImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  //image: NetworkImage(''), // convert to URL
                  image: AssetImage(HomeScreenAssets.lgLogo),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text(
        //       parseDateTime(),
        //       style: const TextStyle(
        //         fontSize: 8,
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
   String parseDateTime() {
    if (timePosted != null) {
      String formatter = DateFormat('dd/MM/yyyy').format(timePosted!);
      return formatter;
    } else {
      return '1/1/2001';
    }
  }
}
