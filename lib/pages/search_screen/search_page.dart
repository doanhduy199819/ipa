import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/pages/search_screen/article_for_search.dart';
import 'package:flutter_interview_preparation/pages/search_screen/company_for_search.dart';
import 'package:flutter_interview_preparation/pages/search_screen/qa_for_search.dart';
import 'package:intl/intl.dart';
import '../../values/Home_Screen_Fonts.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int choice = 0;
  String searchTitle="";
  Color choose=Colors.grey;
  Color not_choose=Color(0xffD8D8D8);

  Row searchFilter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              choice = 0;
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 4 - 5,
            decoration: BoxDecoration(
              color: choice==0?choose:not_choose,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'All',
                  style: TextStyle(
                    fontFamily: FontFamily.urbanist,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              choice = 1;
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 4 - 5,
            decoration: BoxDecoration(
              color: choice==1?choose:not_choose,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Articles',
                  style: TextStyle(
                    fontFamily: FontFamily.urbanist,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              choice = 2;
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 4 - 5,
            decoration: BoxDecoration(
              color: choice==2?choose:not_choose,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Q&A',
                  style: TextStyle(
                    fontFamily: FontFamily.urbanist,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              choice = 3;
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 4 - 5,
            decoration: BoxDecoration(
              color: choice==3?choose:not_choose,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Company',
                  style: TextStyle(
                    fontFamily: FontFamily.urbanist,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Padding searchBox() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextField(
          onChanged: (text){
            setState(() {
              searchTitle=text;
            });
          },
          cursorColor: Colors.black,
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search),
              hintText: 'Search'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: ListView(
          children: [
            searchBox(),
            searchFilter(),
            Visibility(
                visible: choice == 0 && searchTitle.compareTo('')!=0,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child:  ArticleForSearch(searchTitle: searchTitle),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: QAForSearch(searchTitle: searchTitle),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: CompanyForSearch(searchTitle: searchTitle,)
                    ),
                  ],
                )),
            Visibility(
                visible: choice == 1 && searchTitle.compareTo('')!=0,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: ArticleForSearch(searchTitle: searchTitle),
                    ),
                  ],
                )),
            Visibility(
                visible: choice == 2 && searchTitle.compareTo('')!=0,
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: QAForSearch(searchTitle: searchTitle)
                    ),
                  ],
                )),
            Visibility(
                visible: choice == 3 && searchTitle.compareTo('')!=0,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: CompanyForSearch(searchTitle: searchTitle,),
                    ),
                  ],
                )),
          ],
        ));
  }

  String parseDateTime(DateTime? time) {
    if (time != null) {
      String formatter = DateFormat('dd/MM/yyyy').format(time);
      return formatter;
    } else {
      return '1/1/2001';
    }
  }
}
