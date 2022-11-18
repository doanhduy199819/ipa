import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Assets.dart';
import 'package:intl/intl.dart';

class CompanyBloc extends StatelessWidget {
  final String? urlImage;
  const CompanyBloc(
      {Key? key,
      required this.urlImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Image.asset(
        urlImage ?? HomeScreenAssets.lgLogo,
        fit: BoxFit.cover,
      ),
    );
  }
}
