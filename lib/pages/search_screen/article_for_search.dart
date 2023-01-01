import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_interview_preparation/objects/FirestoreUser.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/objects/Helper.dart';
import 'package:flutter_interview_preparation/pages/components/user_info_box.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article/article_details.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Fonts.dart';
import 'package:jiffy/jiffy.dart';

class ArticleForSearch extends StatefulWidget {
  String searchTitle;

  ArticleForSearch({Key? key, required this.searchTitle}) : super(key: key);

  @override
  State<ArticleForSearch> createState() => _ArticleForSearchState();
}

class _ArticleForSearchState extends State<ArticleForSearch> {
  late List<ArticlePost> _post;
  late bool like_check;
  late bool bookmard_check;

  void initData() {
    like_check = false;
    bookmard_check = false;
  }

  void searchFunction() {
    _post = _post
        .where((element) => element.title!
            .toLowerCase()
            .contains(this.widget.searchTitle.toLowerCase()))
        .toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    initData();
    super.initState();
    // _initSampleData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseService().allArticlesOnce,
      builder:
          (BuildContext context, AsyncSnapshot<List<ArticlePost>?> snapshot) {
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
        _post = snapshot.data! as List<ArticlePost>;
        searchFunction();
        return Container(
          padding: EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: _post.length != 0,
                child: Text(
                  'Article',
                  style: HomeScreenFonts.h1
                      .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              _buildListViewContent(),
            ],
          ),
        );
      },
    );
  }

  void _pushTo(context, Widget widget, Object args) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: false,
        builder: (context) => const ArticleDetailScreen(),
        settings: RouteSettings(
          arguments: args,
        ),
      ),
    );
  }

  Column _buildListViewContent() {
    final String sampleTitle = 'No title';
    final String photoUrl =
        'https://images.pexels.com/photos/5245865/pexels-photo-5245865.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
    final String articlePhotoUrl =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPhthE22spXytCuZqX6_MiwxI16wlJV-03UA&usqp=CAU';

    return Column(
        children: List.generate(_post.length, (index) {
      return InkWell(
        onTap: () {
          dynamic args = {
            "articlePost": _post[index],
          };
          Helper.pushTo(context, const ArticleDetailScreen(), args);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
                offset: Offset(0.0, 3),
                color: Colors.grey,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAvatarAndAuthorName(
                authorId: _post[index].author_id ?? '0',
              ),
              _buildArticleTitleAndImage(
                articleTitle: _post[index].title ?? sampleTitle,
                articlePhotoUrl: _post[index].photoUrl ?? articlePhotoUrl,
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.timer_rounded,
                        color: Colors.grey,
                        size: 14,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        _buildCreate_at(_post[index].created_at),
                        style: HomeScreenFonts.author,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.favorite_rounded,
                                size: 18,
                                color: Colors.red.shade300,
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                _buildLike(_post[index].liked_users?.length),
                                style: HomeScreenFonts.description,
                              ),
                            ],
                          )),
                      const SizedBox(width: 16.0),
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.bookmark_border_rounded,
                          size: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }));
  }

  String _buildLike(int? sl) {
    return sl == null ? '0' : '${sl}';
  }

  String _buildCreate_at(DateTime? dateTime) {
    return dateTime?.year == DateTime.now().year
        ? Jiffy(dateTime).MMMd.toString()
        : Jiffy(dateTime).fromNow();
  }
}

class _buildAvatarAndAuthorName extends StatelessWidget {
  const _buildAvatarAndAuthorName({
    Key? key,
    required this.authorId,
  }) : super(key: key);

  final String authorId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseService().getFirestoreUser(authorId),
      builder: (context, AsyncSnapshot<FirestoreUser?> snapshot) =>
          Helper.handleSnapshot(snapshot) ??
          UserInfoBox(
            photoUrl: snapshot.data?.photoUrl,
            userName: snapshot.data?.displayName,
          ),
    );
  }
}

class _buildArticleTitleAndImage extends StatelessWidget {
  const _buildArticleTitleAndImage({
    Key? key,
    required this.articlePhotoUrl,
    required this.articleTitle,
  }) : super(key: key);

  final String articleTitle;
  final String articlePhotoUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: RichText(
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              text: articleTitle,
              // text: 'a',
              style: HomeScreenFonts.title,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Align(
            alignment: Alignment.centerRight,
            child: Image(
              image: NetworkImage(articlePhotoUrl),
              height: MediaQuery.of(context).size.height * 0.1,
            ),
          ),
        ),
      ],
    );
  }
}
