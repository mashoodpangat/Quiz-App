import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/controller/providerPage.dart';
import 'package:quiz_app/views/resultpage.dart';

enum providerstatus { LOADING, COMPLETED }

class HomePage extends StatelessWidget {
  bool match = false;
  int pageIndex = 1;
  int buttonindex = -1;
  int mark = 0;
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionProvider>(builder: (context, getdata, child) {
      getdata.fetchQuestion();
      // if (getdata.status == providerstatus.COMPLETED) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 172, 230, 230),
         
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60, left: 150),
                child: Container(
                  height: 50,
                  width: 200,
                  child: const Text(
                    'Quiz',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 290),
                child: Container(
                  height: 35,
                  width: 60,
                  decoration: BoxDecoration(
                    boxShadow: [
                      const BoxShadow(
                          offset: Offset(1, 9),
                          color: Color.fromARGB(255, 94, 92, 92),
                          blurRadius: 10),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Center(child: Text('${pageIndex}/10')),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                  height: 150,
                  width: 360,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Text(
                    getdata.data[0].questions[pageIndex].question,
                    // getdata.datas['questions'][pageIndex]['question'],
                    style: const TextStyle(fontSize: 15),
                  ))),
              const Divider(
                indent: 25,
                endIndent: 25,
                color: Color.fromARGB(255, 17, 17, 17),
              ),
              const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Blue_question_mark_icon.svg/2048px-Blue_question_mark_icon.svg.png',
                  scale: 1.0,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              const Text(
                'Choose an answer',
                style: TextStyle(color: Color.fromARGB(255, 41, 40, 40)),
              ),
              Container(
                height: 300,
                width: 360,
                color: const Color.fromARGB(255, 172, 230, 230),
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(5),
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        // color: Colors.blue,

                        color:
                            buttonindex == index ? Colors.black : Colors.blue,

                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: () {
                          buttonindex = index;
                          getdata.answercheck(index, buttonindex, pageIndex);
                        },
                        child: Center(
                            child: Text(
                         
                          getdata.data[0].questions[pageIndex].answers[index],
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        )),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 250),
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                    onPressed: () {
                      getdata.nextQuestion();
                      buttonindex;
                      getdata.changevalue();
                      // (getdata.datas['questions'][pageIndex]['answers']
                      //     [buttonindex]);
                      // buttonindex ==
                      //         quiz.datas['questions'][pageIndex]['correctIndex']
                      //     ? mark++
                      //     : null;
                      // print(mark);

                      buttonindex = -1;
                      pageIndex < 10
                          ? pageIndex++
                          : Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Resultspage(),
                            ));
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      // } else {
      //   return Container(
      //       height: 50,
      //       width: 50,
      //       child: Center(child: const CircularProgressIndicator()));
      // }
    });
  }
}
