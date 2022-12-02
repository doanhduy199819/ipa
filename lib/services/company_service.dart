import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_interview_preparation/objects/Company.dart';

mixin CompanyService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  List<Company>? _companiesFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    return querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return Company.fromDocumentSnapshot(documentSnapshot);
      }
      return Company.test();
    }).toList();
  }

  Future<List<Company>?> get allCompanyOnce {
    return _db.collection('companies').get().then(_companiesFromQuerySnapshot);
  }

  Future<String?> getACompany(String? idCompany) async {
    List<Company>? temp = await allCompanyOnce as List<Company>?;
    for (int i = 0; i < (temp?.length ?? 0); i++) {
      if (temp?[i].idCompany.compareTo(idCompany??'') == 0) {
        return temp?[i].logoUrl;
      }
    }
    return '';
  }
}
