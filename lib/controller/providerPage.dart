import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:quiz_app/views/homePage.dart';

import '../model/apiModel.dart';

enum providerstatus { LOADING, COMPLETED }

class QuestionProvider with ChangeNotifier {
  List<Welcome> data = [];
  providerstatus status = providerstatus.LOADING;

  fetchQuestion() async {
    final response = await http
        .get(Uri.parse('https://637dbfffcfdbfd9a639bba1e.mockapi.io/sample'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      data = welcomeFromJson(response.body);
      status = providerstatus.COMPLETED;
      //  status = ProviderStatus.COMPLETED;
    } else {
      throw Exception('Failed to load album');
    }
    notifyListeners();
  }

  bool match = false;
  late dynamic _questionIndex = 0;
  int pageIndex = 1;
  int buttonindex = -1;
  int mark = 0;


  void nextQuestion() {
    _questionIndex = (_questionIndex + 1) % data.length;
    notifyListeners();
  }

  void answercheck(int index, int buttonindex, pageIndex) {
    buttonindex = index;
    buttonindex == data[0].questions[pageIndex].correctIndex
        ? match = true
        : match = false;

    notifyListeners();
  }

  void changevalue({bool reset = false}) {
    if (match) {
      mark++;
      match = false;
    }
    if (reset) {
      mark = 0;
    }
    notifyListeners();
  }
}
