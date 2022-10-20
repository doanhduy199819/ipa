import 'package:flutter/material.dart';

class ViewSingleQuestionWidget extends StatelessWidget {
  ViewSingleQuestionWidget({Key? key}) : super(key: key);

  int? questionNumber = 1;
  int? totalNumberOfQuestions = 32;
  // final String sampleQuestion = 'What is the meaning of CPU?';
  final String sampleQuestion =
      'HTML(Hypertext Markup Language) has language elements which permit certain actions other than describing the structure of the web document. Which one of the following actions is NOT supported by pure HTML (without any server or client side scripting)pages?';
  final List<String> sampleAnswers = [
    'Embed web objects from different sites into the same page',
    'Refresh the page automatically after a specified interval',
    'Automatically redirect to another page upon download',
    'Display the client time as part of the page',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.apps),
            onPressed: () {
              print('Select question is pressed');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuestionNumber(
                questionNumber: questionNumber,
                totalNumberOfQuestions: totalNumberOfQuestions), // For title
            const SizedBox(height: 20.0),
            _buildQuestionContent(sampleQuestion: sampleQuestion),
            const SizedBox(height: 20.0),
            Divider(
              indent: 50.0,
              endIndent: 50.0,
              thickness: 1.5,
            ),
            _buildAnswers(sampleAnswers: sampleAnswers), // For answer a,b,c,d
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildPreNextButtons(),
    );
  }
}

class _buildQuestionContent extends StatelessWidget {
  const _buildQuestionContent({
    Key? key,
    required this.sampleQuestion,
  }) : super(key: key);

  final String sampleQuestion;
  final double textSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 32, // 32 is for padding
          child: Text(
            sampleQuestion,
            style: TextStyle(fontSize: textSize, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

class _buildQuestionNumber extends StatelessWidget {
  const _buildQuestionNumber({
    Key? key,
    required this.questionNumber,
    required this.totalNumberOfQuestions,
  }) : super(key: key);

  final int? questionNumber;
  final int? totalNumberOfQuestions;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: 'Questions: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 24.0,
                )),
            TextSpan(
              text: '$questionNumber of $totalNumberOfQuestions',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _buildAnswers extends StatefulWidget {
  const _buildAnswers({
    Key? key,
    required this.sampleAnswers,
  }) : super(key: key);

  final List<String> sampleAnswers;

  @override
  State<_buildAnswers> createState() => _buildAnswersState(sampleAnswers);
}

class _buildAnswersState extends State<_buildAnswers> {
  _buildAnswersState(this._sampleAnswers);

  late final List<String> _sampleAnswers;
  String? _selectedValue = 'A';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSingleAnswer(_sampleAnswers[0], 'A'),
          const SizedBox(height: 5.0),
          _buildSingleAnswer(_sampleAnswers[1], 'B'),
          const SizedBox(height: 5.0),
          _buildSingleAnswer(_sampleAnswers[2], 'C'),
          const SizedBox(height: 5.0),
          _buildSingleAnswer(_sampleAnswers[3], 'D'),
        ],
      ),
    );
  }

  Container _buildSingleAnswer(String text, String value) {
    return Container(
      decoration: BoxDecoration(
        // ignore: prefer_const_constructors
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(50.0),
          bottomLeft: const Radius.circular(50.0),
          topRight: const Radius.circular(5.0),
          bottomRight: const Radius.circular(5.0),
        ),
        border: Border.all(
          width: 0.8,
          color: Colors.blueGrey,
        ),
      ),
      child: RadioListTile<String>(
        selected: true,
        title: Text(
          text,
        ),
        value: value,
        groupValue: _selectedValue,
        contentPadding: const EdgeInsets.only(right: 8.0),
        onChanged: (String? value) {
          setState(() {
            _selectedValue = value;
          });
        },
      ),
    );
  }
}

class _buildPreNextButtons extends StatelessWidget {
  const _buildPreNextButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            // child: FloatingActionButton(
            //   backgroundColor: Colors.green,
            //   child: const Icon(Icons.arrow_back_rounded),
            //   onPressed: () {
            //     print('Left button is pressed');
            //   },
            // ),
            child: FlatButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text('Previous'),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            // child: FloatingActionButton(
            //   backgroundColor: Colors.green,
            //   child: const Icon(Icons.arrow_forward_rounded),
            //   onPressed: () {
            //     print('Right button is pressed');
            //   },
            // ),
            child: FlatButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text('Next'),
                  SizedBox(
                    width: 5.0,
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
