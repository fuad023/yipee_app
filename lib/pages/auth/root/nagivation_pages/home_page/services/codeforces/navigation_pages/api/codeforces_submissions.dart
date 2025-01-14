import 'package:http/http.dart';
import 'dart:convert';

import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/navigation_pages/api/cf_user_info.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/navigation_pages/api/codeforces_api.dart';


class CodeforcesSubmissions extends CodeforcesApi {
  late List<Result> result;

  @override
  Future<void> fetchSubmissions(String handle) async {
    Response response = await get(Uri.parse("${baseURL}user.status?handle=$handle"));
    Map<String, dynamic> data = jsonDecode(response.body);
    
    
    if (data["status"] == "FAILED") {
      throw Exception(data["comment"]);
    } else if (data["status"] == "OK") {
      List dataList = data["result"];

      for (var x in dataList) {
        print(x);
      }
    }
  }



















  @override
  Future<bool> checkValidity(String handle) { throw UnimplementedError(); }
  @override
  CodeforcesUserInfo getUserInfo() { throw UnimplementedError(); }
  @override
  Future<void> setUserInfo(String handle) { throw UnimplementedError(); }
}

class Result {
  Problem problem;
  String? verdict;

  Result({
    required this.problem,
    required this.verdict,
  });

  String getVerdict() {
    return "$verdict";
  }
}

class Problem {
  int? contestId;
  String index;
  String name;
  int? rating;

  Problem({
    required this.contestId,
    required this.index,
    required this.name,
    required this.rating,
  });

  String getIdName() {
    return "$contestId$index. $name";
  }

  String getRating() {
    return "$rating";
  }
}