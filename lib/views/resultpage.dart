import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/controller/providerPage.dart';

import 'homePage.dart';

class Resultspage extends StatelessWidget {
  const Resultspage({super.key});
  // bool win = mark >= 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 172, 230, 230),
      // appBar: AppBar(
      //   backgroundColor: Colors.blue,
      // ),
      // body: Column(
      // children: [Text('${mark}')],
      // ),
      body: Stack(
        children: [
          context.read<QuestionProvider>().mark >= 5
              ? LottieBuilder.network(
                  'https://assets2.lottiefiles.com/packages/lf20_8edlac32.json')
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 240),
                    child: LottieBuilder.network(
                        'https://assets7.lottiefiles.com/packages/lf20_9xRnlw.json'),
                  ),
                ),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 80),
                child: Text(
                  'Result',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: CircularPercentIndicator(
                    radius: 120,
                    animation: true,
                    startAngle: 180,
                    lineWidth: 25.0,
                    percent: context.read<QuestionProvider>().mark / 10,
                    animationDuration: 2000,
                    reverse: false,
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Text(
                      "${context.read<QuestionProvider>().mark}/10",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        letterSpacing: -0.1,
                      ),
                    ),
                    progressColor: context.read<QuestionProvider>().mark >= 5
                        ? Colors.green
                        : Colors.orange,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 200),
                height: 60,
                width: 200,
                decoration: BoxDecoration(
                  color: context.read<QuestionProvider>().mark >= 5
                      ? Colors.green
                      : Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    context.read<QuestionProvider>().mark >= 5
                        ? "Awesome"
                        : 'Ooops..!',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextButton(
                  onPressed: () {
                    context.read<QuestionProvider>().mark = 0;
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
                  },
                  child: Text(
                    context.read<QuestionProvider>().mark >= 5
                        ? " play again"
                        : 'try again ',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
