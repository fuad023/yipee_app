import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/api/codeforces_api.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/api/codeforces_user.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/api/codeforces_submissions.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/api/codeforces_rating_history.dart';

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

        data["result"].reversed.forEach((map) {
          if (map["phase"] == "BEFORE") {
            result.add(
              ResultContestList(
                name: map["name"],
                phase: map["phase"],
                durationSeconds: map["durationSeconds"],
                startTimeSeconds: map["startTimeSeconds"],
              )
            );
          }
        });
        return result;
      }
      
    } on Exception catch (e) {
      print('Caught an error in CodeforcesContestList class: $e'); // ignore: avoid_print
    }
    return null;
  }

  @override
  Future<bool> checkValidity(String handle) { throw UnimplementedError(); }
  @override
  Future<ResultUser?> fetchUser(String handle) { throw UnimplementedError(); }
  @override
  Future<List<ResultSubmissions>?> fetchSubmissions(String handle) { throw UnimplementedError(); }
  @override
  Future<List<ResultRatingHistory>?> fetchRatingHistory(String handle) => throw UnimplementedError();
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

  String getName() => name;
  String getDuration() => _durationString();
  String getStartTime() => _getFormattedTime();

  String _getFormattedTime() {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(startTimeSeconds! * 1000);
    return DateFormat('dd MMM yyyy | h:mm aa').format(dateTime);
  }

  String _durationString() {
    String duration = "";
    int sec = durationSeconds;

    if (sec > 86400) {
      duration += "${sec~/86400} day(s) ";
      sec %= 86400;
    }
    if (sec > 3600) {
      duration += "${sec~/3600} hours(s) ";
      sec %= 3600;
    }
    if (sec > 60) {
      duration += "${sec~/60} minute(s) ";
      sec %= 60;
    }
    if (sec > 0) {
      duration += "$sec second(s) ";
    }

    return duration;
  }
}