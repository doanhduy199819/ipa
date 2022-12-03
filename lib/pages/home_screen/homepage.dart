import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article/article_content.dart';
import 'package:flutter_interview_preparation/pages/profile_screen/profile_page.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Fonts.dart';

import '../../objects/Question.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool isArticleTab;
  List<String> categories = <String>[
    'For you',
    'All',
    'Popular',
    'Algorithm',
  ];

  List<Question> display_list_question =
      List.from(Question.getSampleQuestions());

  // @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isArticleTab = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Color.fromARGB(255, 233, 240, 243),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    debugPrint('Rebuild Appbar');
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(
        'Home',
        style: HomeScreenFonts.headStyle,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProfilePage()));
          },
        ),
      ],
    );
  }

  Widget _buildMenu() {
    debugPrint('Rebuild Menu');

    // return SingleChildScrollView(
    //   scrollDirection: Axis.horizontal,
    //   child: Row(
    //     children: [
    //       // _cardCategory('+'),
    //       _cardCategory('For you'),
    //       _cardCategory('All'),
    //       _cardCategory('Popular'),
    //       _cardCategory('Algorithm'),
    //       _cardCategory('Language'),
    //     ],
    //   ),
    // );
    return _buildListCategories();
  }

  Widget _buildBody() {
    debugPrint('Rebuild Body');
    return  Column(
      //list articles post
      children: [
        Expanded(
          flex: 1,
          child: _buildMenu(), // Extract to method for short code
        ),
        const Expanded(
          flex: 9,
          child: ArticleContent(),
        )
      ],
    );
  }

  Card _cardCategory(String string) {
    debugPrint('Rebuild Card catergory');
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(48.0),
      ),
      //color: Colors.cyanAccent[100],//after tab this card
      color: Colors.lightBlue[100],
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: FlatButton(
          child: Text(
            '${string}',
            style: HomeScreenFonts.category,
            // textWidthBasis: TextWidthBasis.parent,
          ),
          // minWidth: double.minPositive,
          onPressed: () {
            //do something
          },
        ),
      ),
    );
  }

  ListView _buildListCategories() {
    debugPrint('Rebuild List catergories');
    return ListView.builder(
      itemBuilder: (_, index) {
        return _cardCategory(categories[index]);
      },
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
    );
  }
}
