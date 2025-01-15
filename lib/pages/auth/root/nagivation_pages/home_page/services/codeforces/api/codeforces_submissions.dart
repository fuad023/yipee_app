import 'package:http/http.dart';
import 'dart:convert';

import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/api/codeforces_api.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/api/codeforces_user.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/api/codeforces_contest_list.dart';

class CodeforcesSubmissions extends CodeforcesApi {
  List<ResultSubmissions> result = [];

  @override
  Future<List<ResultSubmissions>?> fetchSubmissions(String handle) async {
    try {
      Response response = await get(Uri.parse("${baseURL}user.status?handle=$handle"));
      Map<String, dynamic> data = jsonDecode(response.body);
    
      if (data["status"] == "FAILED") {
        throw Exception(data["comment"]);
      } else if (data["status"] == "OK") {
        List dataList = data["result"];

        for (var map in dataList) {
          result.add(
            ResultSubmissions(
              creationTimeSeconds: map["creationTimeSeconds"],
              problem: Problem(
                contestId: map["problem"]["contestId"],
                index: map["problem"]["index"],
                name: map["problem"]["name"],
                rating: map["problem"]["rating"],
              ),
              author: Author(
                participantType: map["author"]["participantType"],
              ),
              verdict: map["verdict"],
            )
          );
        }
        return result;
      }
    } on Exception catch (e) {
      print('Caught an error in CodeforcesSubmissions class: $e'); // ignore: avoid_print
    }
    return null;
  }

  @override
  Future<bool> checkValidity(String handle) { throw UnimplementedError(); }
  @override
  Future<ResultUser?> fetchUser(String handle) { throw UnimplementedError(); }
  @override
  Future<List<ResultContestList>?> fetchContestList() { throw UnimplementedError(); }
}

class ResultSubmissions {
  int creationTimeSeconds;
  Problem problem;
  Author author;
  String? verdict;

  ResultSubmissions({
    required this.creationTimeSeconds,
    required this.problem,
    required this.author,
    required this.verdict,
  });

  String getIdName()  { return "${problem.contestId}${problem.index}. ${problem.name}"; }
  String getRating()  { return (problem.rating == null) ? "NOT RATED" : "${problem.rating}"; }
  String getVerdict() { return "$verdict"; }
  String getCreatedWhen() { return timeAgo(creationTimeSeconds); }
  String getParticipantType() { return author.participantType; }

  String timeAgo(int unixTime) {
    DateTime inputTime = DateTime.fromMillisecondsSinceEpoch(unixTime * 1000);
    DateTime now = DateTime.now();
    Duration difference = now.difference(inputTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else {
      return '${(difference.inDays / 365).floor()} years ago';
    }
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
}

class Author {
  String participantType;

  Author({
    required this.participantType,
  });
}