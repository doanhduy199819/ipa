import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/objects/Company.dart';
import 'package:flutter_interview_preparation/values/Quizz_Screen_Fonts.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../../objects/Account.dart';
import '../../objects/Comment.dart';
import '../../objects/Questions.dart';
import '../../values/Home_Screen_Assets.dart';
import '../../values/Home_Screen_Fonts.dart';

class SearchCompanyScreen extends StatefulWidget {
  const SearchCompanyScreen({Key? key}) : super(key: key);
  @override
  State<SearchCompanyScreen> createState() => _SearchCompanyScreenState();
}

class _SearchCompanyScreenState extends State<SearchCompanyScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffD8F5F5),
          title: Text(
            'Post A Question',
            style: HomeScreenFonts.h1,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Image.asset(
              HomeScreenAssets.backButton,
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Related Company',
                style: HomeScreenFonts.h2,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: const Color(0xffD8F5F5),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search'),
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Company',
                          style: HomeScreenFonts.h1.copyWith(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        companyPart()
                      ],
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }

  Column companyPart() {
    // double widthOfDevice = MediaQuery.of(context).size.width;
    // double heightOfDevice = MediaQuery.of(context).size.height;
    List _companyList = <Company>[];
    _companyList
      ..add(new Company('0', 'LG VCS DANANG', 'assets/images/lg_is.png'))
      ..add(new Company(
          '1', 'SAM SUNG ELECTRONIC VIETNAM', 'assets/images/samsung_is.png'))
      ..add(new Company(
          '2', 'TRONG HUY COMPUTER COMPANY', 'assets/images/fujitsu_is.png'));
    return Column(
        children: List.generate(_companyList.length, (index) {
      return InkWell(
        onTap: () {},
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
                  // height: heightOfDevice / 9-20,
                  // width: widthOfDevice / 9 +30,
                  height: 50,
                  width: 90,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.black),
                  child: Center(
                      child: Image(
                    image: AssetImage(_companyList[index].logo),
                    // height: heightOfDevice / 9,
                    // width: widthOfDevice / 10,
                    height: 40,
                    width: 80,
                  )),
                ),
              ),
              Container(
                //width: widthOfDevice,
                width: 200,
                child: RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: _companyList[index].name,
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
