import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Quiz.dart';
import 'package:flutter_interview_preparation/pages/quizz_screen/quiz_result.dart';
import 'package:flutter_interview_preparation/pages/quizz_screen/quizz_view_all_question.dart';

class ViewSingleQuestionWidget extends StatefulWidget {
  const ViewSingleQuestionWidget({Key? key}) : super(key: key);

  @override
  State<ViewSingleQuestionWidget> createState() =>
      _ViewSingleQuestionWidgetState();
}
int currentQuestion =0;
int totalNumberOfQuestions = 0;
String? _selectedValue = '';
late bool isDone;
class _ViewSingleQuestionWidgetState extends State<ViewSingleQuestionWidget> {

  @override
  void initState() {
    // TODO: implement initState
    if(listQuiz.isEmpty)
      {
        listQuiz..add(
            new Quiz('HTML(Hypertext Markup Language) has language elements which permit certain actions other than describing the structure of the web document. Which one of the following actions is NOT supported by pure HTML (without any server or client side scripting)pages?', ['Embed web objects from different sites into the same page',
              'Refresh the page automatically after a specified interval',
              'Automatically redirect to another page upon download',
              'Display the client time as part of the page',],1,-1))
          ..add(new Quiz('1+1=?', ['2','4','3','14'],0,-1))
          ..add(new Quiz('2+2=?', ['3','4','5','6'],1,-1))
          ..add(new Quiz('3+7', ['13','12','11','10'],3,-1))
          ..add(new Quiz('8-8 ', ['14','0','16','7'],1,-1))
          ..add(new Quiz('5*7', ['44','27','40','35'],3,-1))
          ..add(new Quiz('2*4', ['8','4','3','2'],0,-1))
          ..add(new Quiz('7*8', ['65','56','2','1'],1,-1))
          ..add(new Quiz('7*6', ['42','24','84','82'],0,-1))
          ..add(new Quiz('8*10', ['80','88','74','44'],0,-1))
        ;
        isDone=false;
        currentQuestion =0;
      }

    totalNumberOfQuestions=listQuiz.length;
    super.initState();
  }

  Container _buildQuestionNumber() {
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
              text: '${currentQuestion+1} of $totalNumberOfQuestions',
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

  Row _buildQuestionContent() {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 32, // 32 is for padding
          child: Text(
            listQuiz[currentQuestion%totalNumberOfQuestions ].content,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }



  Padding _buildPreNextButtons()
  {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FlatButton(
            onPressed: () {
              setState(() {
                if(currentQuestion==0)
                  currentQuestion=listQuiz.length-1;
                else
                  currentQuestion--;

              });
            },
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

          Text('${currentQuestion+1} of $totalNumberOfQuestions',style: TextStyle(
            fontWeight: FontWeight.bold
          ),),

          FlatButton(
            onPressed: () {
              setState(() {
                if(currentQuestion==listQuiz.length-1)
                  currentQuestion=0;
                else
                currentQuestion++;
              });
            },
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
          )
        ],
      )


    );
  }

  Container _buildAnswers()
  {
    List<String> _sampleAnswers=listQuiz[currentQuestion%totalNumberOfQuestions].listSuggest;

    if(listQuiz[currentQuestion].myAnswer>-1)
       _selectedValue=listQuiz[currentQuestion].myAnswer.toString();
    else
      _selectedValue='';



    Container _buildSingleAnswer(String text, int value) {
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
          selected: false,
          title: Text(
            text,style: TextStyle(
            color: isDone==false? Colors.black:
            (listQuiz[currentQuestion].correctAnswer==value?Colors.green:Colors.red),
          ),
          ),
          value: value.toString(),
          groupValue: _selectedValue,
          contentPadding: const EdgeInsets.only(right: 8.0),
          onChanged: (String? value) {
            setState(() {

              if(isDone==false)
                {
                  _selectedValue=value;
                  listQuiz[currentQuestion].myAnswer=int.parse(value!);
                  print(_selectedValue);
                }
            });
          },
        ),
      );
    }

    return  Container(
      padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSingleAnswer(_sampleAnswers[0], 0),
          const SizedBox(height: 5.0),
          _buildSingleAnswer(_sampleAnswers[1], 1),
          const SizedBox(height: 5.0),
          _buildSingleAnswer(_sampleAnswers[2], 2),
          const SizedBox(height: 5.0),
          _buildSingleAnswer(_sampleAnswers[3], 3),
        ],
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Do you want to submit this quiz?',style: TextStyle(
            fontWeight: FontWeight.bold
          ),),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('You can review all of question carefully before do this?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                isDone=true;
                Navigator.push(context, MaterialPageRoute(builder: (context)=>QuizResult())).then((value) {Navigator.of(context, rootNavigator: true).pop();setState(() {
                  currentQuestion=0;
                });;});
            
              },
            ),
          ],
        );
      },
    );
  }

  Row _buildExplanation()
  {
    return Row(
      children: [
        Text('Explanation:',style: TextStyle(fontWeight: FontWeight.bold),),
        listQuiz[currentQuestion].myAnswer==listQuiz[currentQuestion].correctAnswer?Text('True',style: TextStyle(color: Colors.green),):Text('False',style: TextStyle(color: Colors.red),),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.apps),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ViewAllQuestion())).then((value) {setState(() {
                    currentQuestion*=1;
                  });});
            },
          ),

          Visibility(child: InkWell(
            onTap: () {
              _showMyDialog();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffC7EDE6),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "SUBMIT",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Arial",
                  ),
                ),
              ),
            ),
          ),visible: !isDone,)
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuestionNumber(), // For title
            const SizedBox(height: 20.0),
            _buildQuestionContent(),
            const SizedBox(height: 20.0),
            Divider(
              indent: 50.0,
              endIndent: 50.0,
              thickness: 1.5,
            ),
            _buildAnswers(), // For answer a,b,c,d
            const SizedBox(height: 40.0),
            Visibility(child: _buildExplanation(),visible: isDone,)
            ,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildPreNextButtons(),
    );

  }
}


