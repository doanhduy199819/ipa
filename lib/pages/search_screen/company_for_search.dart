import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Company.dart';
import 'package:flutter_interview_preparation/pages/search_screen/qa_of_the_company.dart';

import '../../services/database_service.dart';
import '../../values/Home_Screen_Fonts.dart';

class CompanyForSearch extends StatefulWidget {
  String searchTitle;
  CompanyForSearch({Key? key, required this.searchTitle}) : super(key: key);

  @override
  State<CompanyForSearch> createState() => _CompanyForSearchState();
}

class _CompanyForSearchState extends State<CompanyForSearch> {
  late List<Company> _company;

  void searchFunction() {
    _company = _company
        .where((element) => element.name!
            .toLowerCase()
            .contains(this.widget.searchTitle.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseService().allCompanyOnce,
      builder: (BuildContext context, AsyncSnapshot<List<Company>?> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong :(');
        }
        if (snapshot.data == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: [
              CircularProgressIndicator(),
            ],
          );
        }
        _company = snapshot.data! as List<Company>;
        searchFunction();
        return Container(
            padding: EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: _company.length != 0,
                  child: Text(
                    'Company',
                    style: HomeScreenFonts.h1
                        .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                companyPart(),
              ],
            ));
      },
    );
  }

  Column companyPart() {
    return Column(
        children: List.generate(_company.length, (index) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: false,
              builder: (context) => CompanyQA(
                idCompany: _company[index].id!,
                nameCompany: _company[index].name!,
              ),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 5),
          decoration: const BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              blurRadius: 2,
              offset: Offset(0.0, 3),
              color: Colors.grey,
            ),
          ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(12),
                child: Container(
                  height: MediaQuery.of(context).size.height / 9 - 20,
                  width: MediaQuery.of(context).size.height / 9 + 30,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.black),
                  child: Center(
                      child: Image(
                    image: NetworkImage(_company[index].logoUrl!),
                    height: MediaQuery.of(context).size.height / 9,
                    width: MediaQuery.of(context).size.width / 10,
                  )),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: _company[index].name,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 40,
              ),
            ],
          ),
        ),
      );
    }));
  }
}
