import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article/article_content.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddArticleAdmin extends StatefulWidget {
  const AddArticleAdmin({Key? key}) : super(key: key);

  @override
  State<AddArticleAdmin> createState() => _AddArticleAdminState();
}

class _AddArticleAdminState extends State<AddArticleAdmin> {
  late String? title;
  late String? content;
  late DateTime? created_at = DateTime.now();
  final _db = DatabaseService();
  final _formStateKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(flex: 1, child: ArticleContent()),
            Expanded(flex: 1, child: _inputPart()),
          ],
        ),
      ),
    );
  }

  Container _inputPart() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formStateKey,
        child: Column(
          children: [
            SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(
                label: Text('Title'),
              ),
              onChanged: (val) {
                title = val;
              },
            ),
            InputDatePickerFormField(
              initialDate: created_at,
              onDateSaved: (DateTime date) {
                setState(() {
                  created_at = date;
                  DateTime d = DateTime.parse(created_at.toString());
                  print(DateFormat('dd/MM/yyyy').format(d));
                });
              },
              fieldHintText: 'dd/MM/yyyy',
              firstDate: DateTime.now(),
              lastDate: DateTime(2050, 12, 31),
            ),
            Container(
                // height: 200.0,
                color: Colors.greenAccent.shade100,
                child: TextFormField(
                  decoration: InputDecoration(label: Text('Content')),
                  // keyboardType: TextInputType.multiline,
                  // maxLines: null,
                  onChanged: (val) => content = val,
                )),
            SizedBox(height: 20.0),
            FlatButton(
              onPressed: () {
                if (_formStateKey.currentState!.validate())
                  _formStateKey.currentState?.save();

                ArticlePost articlePost = ArticlePost.only(
                    title: title, content: content, created_at: created_at);
                _db.addArticle(articlePost);
              },
              child: Text('Add article to FireStore'),
              color: Colors.green,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
