import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Assets.dart';

class Company {
  String? id;
  String? name;
  String? logoUrl;

  Company(this.id, this.name, this.logoUrl);

  Image? logoImage([size]) {
    return Image.asset(logoUrl ?? HomeScreenAssets.lgLogo);
  }

  String get idCompany {
    return id ?? '-1';
  }

  static Company? haveIdCompanyInSample(String idCom) {
    for (int i = 0; i < getSampleCompany().length; i++) {
      if (getSampleCompany()[i].idCompany.compareTo(idCom) == 0) {
        return getSampleCompany()[i];
      }
    }
    return null;
  }

  static List<Company> getSampleCompany() {
    List<Company> _sampleCompany = [];
    // ignore: avoid_single_cascade_in_expression_statements
    _sampleCompany
      ..add(Company('0', 'LG', HomeScreenAssets.lgLogo))
      ..add(Company('1', 'LG', HomeScreenAssets.lgLogo))
      ..add(Company('2', 'LG', HomeScreenAssets.lgLogo))
      ..add(Company('3', 'LG', HomeScreenAssets.lgLogo));
    return _sampleCompany;
  }
}
