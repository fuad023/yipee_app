import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:student_app/pages/root/navigation_pages/home_page/services/codeforces/api/codeforces_api.dart';
import 'package:student_app/pages/root/navigation_pages/home_page/services/codeforces/api/codeforces_user.dart';
import 'package:student_app/pages/root/navigation_pages/home_page/services/codeforces/api/codeforces_submissions.dart';
import 'package:student_app/pages/root/navigation_pages/home_page/services/codeforces/api/codeforces_contest_list.dart';

class CodeforcesRatingHistory extends CodeforcesApi {
  List<ResultRatingHistory>? result;

  @override
  Future<List<ResultRatingHistory>?> fetchRatingHistory(String handle) async {
    try {
      Response response = await get(Uri.parse("${baseURL}user.rating?handle=$handle"));
      Map<String, dynamic> data = jsonDecode(response.body);

      if (data["status"] == "FAILED") {
        throw Exception(data["comment"]);
      } else if (data["status"] == "OK") {
        result = <ResultRatingHistory>[];
        data['result'].forEach((v) {
          result!.add(ResultRatingHistory.fromJson(v));
        });
        return result;
      }
    } catch (e) {
      print('Caught an error in CodeforcesRatingHistory class: $e'); // ignore: avoid_print
    }
    return null;
  }

  @override
  Future<bool> checkValidity(String handle) => throw UnimplementedError();
  @override
  Future<ResultUser?> fetchUser(String handle) => throw UnimplementedError();
  @override
  Future<List<ResultSubmissions>?> fetchSubmissions(String handle) => throw UnimplementedError();
  @override
  Future<List<ResultContestList>?> fetchContestList() => throw UnimplementedError();
}

class ResultRatingHistory {
  int? contestId;
  String? contestName;
  String? handle;
  int? rank;
  int? ratingUpdateTimeSeconds;
  int? oldRating;
  int? newRating;

  ResultRatingHistory({
    this.contestId,
    this.contestName,
    this.handle,
    this.rank,
    this.ratingUpdateTimeSeconds,
    this.oldRating,
    this.newRating
  });

  String get getContestId => contestId == null ? "" : "$contestId";
  String get getContestName => contestName ?? "";
  String get getHandle => handle ?? "";
  String get getRank => rank == null ? "" : "$rank";
  String get getRatingUpdateTimeSeconds => ratingUpdateTimeSeconds == null ? "" : getFormattedTimeDateOnly(ratingUpdateTimeSeconds!);
  String get getOldRating => oldRating == null ? "" : "$oldRating";
  String get getNewRating => newRating == null ? "" : "$newRating";

  String getFormattedTimeDateOnly(int unixTimestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  int get getRatingDiff {
    return newRating! - oldRating!;
  }

  ResultRatingHistory.fromJson(Map<String, dynamic> json) {
    contestId = json['contestId'];
    contestName = json['contestName'];
    handle = json['handle'];
    rank = json['rank'];
    ratingUpdateTimeSeconds = json['ratingUpdateTimeSeconds'];
    oldRating = json['oldRating'];
    newRating = json['newRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contestId'] = contestId;
    data['contestName'] = contestName;
    data['handle'] = handle;
    data['rank'] = rank;
    data['ratingUpdateTimeSeconds'] = ratingUpdateTimeSeconds;
    data['oldRating'] = oldRating;
    data['newRating'] = newRating;
    return data;
  }
}