import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Assets.dart';

mixin CompanyService {
  Image? getCompanyLogo(String companyId) {
    return Image.asset(
      HomeScreenAssets.lgLogo,
      fit: BoxFit.cover,
    );
  }
}
