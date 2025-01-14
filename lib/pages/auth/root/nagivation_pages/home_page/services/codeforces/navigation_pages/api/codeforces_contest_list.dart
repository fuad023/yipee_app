import 'package:http/http.dart';
import 'dart:convert';

import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/navigation_pages/api/cf_user_info.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/navigation_pages/api/codeforces_api.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/navigation_pages/api/codeforces_submissions.dart';

class CodeforcesContestList extends CodeforcesApi {
  List<ResultContestList> result = [];

  @override
  Future<List<ResultContestList>?> fetchContestList() async {
    try {
      Response response = await get(Uri.parse("${baseURL}contest.list"));
      Map<String, dynamic> data = jsonDecode(response.body);

      if (data["status"] == "FAILED") {
        throw Exception(data["comment"]);
      } else if (data["status"] == "OK") {
        List dataList = data["result"];

        for (var x in dataList) {
          print(x);
        }
      }
      
    } on Exception catch (e) {
      print('Caught an error in CodeforcesContestList class: $e'); // ignore: avoid_print
    }
    return null;
  }

  @override
  Future<bool> checkValidity(String handle) {    throw UnimplementedError();  }
  @override
  Future<List<ResultSubmissions>?> fetchSubmissions(String handle) {    throw UnimplementedError();  }
  @override
  CodeforcesUserInfo getUserInfo() {    throw UnimplementedError();  }
  @override
  Future<void> setUserInfo(String handle) {    throw UnimplementedError();  }
}

class ResultContestList {
  final String name;
  final String phase;
  final int durationSeconds;
  final int? startTimeSeconds;

  ResultContestList({
    required this.name,
    required this.phase,
    required this.durationSeconds,
    required this.startTimeSeconds,
  });
}