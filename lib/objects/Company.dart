import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Assets.dart';

class Company {
  String? id;
  String? name;
  String? logoUrl;

  Company(this.id, this.name, this.logoUrl);

  String get idCompany{
    return id?? '-1';
  }
  factory Company.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return Company.fromJson(documentSnapshot.data());
  }

  factory Company.fromJson(Map<String, dynamic>? data) {
    final String? id = data?['id'];
    final String? name = data?['name'];
    final String? logoUrl = data?['logoUrl'];

    return Company.only(
      id: id,
      name: name,
      logoUrl: logoUrl,
    );
  }

  Company.only({
    this.id,
    this.name,
    this.logoUrl,
  });


  static Company? haveIdCompanyInSample(String idCom){
    for(int i=0;i<getSampleCompany().length;i++){
      if(getSampleCompany()[i].idCompany.compareTo(idCom)==0){
        return getSampleCompany()[i];
      }
    }
    return null;
  }

  factory Company.test() {
    var id = 'id_test';
    var name='no_name';
    var logoUrl='';
    return Company.only(
      id: id,
      name: name,
      logoUrl: logoUrl,
    );
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
