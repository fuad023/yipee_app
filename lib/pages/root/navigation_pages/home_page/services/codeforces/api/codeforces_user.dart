import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:student_app/pages/root/navigation_pages/home_page/services/codeforces/api/codeforces_api.dart';
import 'package:student_app/pages/root/navigation_pages/home_page/services/codeforces/api/codeforces_submissions.dart';
import 'package:student_app/pages/root/navigation_pages/home_page/services/codeforces/api/codeforces_rating_history.dart';
import 'package:student_app/pages/root/navigation_pages/home_page/services/codeforces/api/codeforces_contest_list.dart';

class CodeforcesUser extends CodeforcesApi {
  late ResultUser result;

  @override
  Future<ResultUser?> fetchUser(String handle) async {
    try {
      Response response = await get(Uri.parse("${baseURL}user.info?handles=$handle"));
      Map<String, dynamic> data = jsonDecode(response.body);

      if (data["status"] == "FAILED") {
        throw Exception(data["comment"]);
      } else if (data["status"] == "OK") {
        result = ResultUser.fromJson(data['result'][0]);
        return result;
      }
    } catch (e) {
      print('Caught an error in CodeforcesUser class: $e'); // ignore: avoid_print
    }
    return null;
  }

  @override
  Future<bool> checkValidity(String handle) async {
    Response response = await get(Uri.parse("${baseURL}user.info?handles=$handle"));
    Map<String, dynamic> data = jsonDecode(response.body);

    return (data["status"] == "OK") ? true : false;
  }

  @override
  Future<List<ResultSubmissions>?> fetchSubmissions(String handle) => throw UnimplementedError();
  @override
  Future<List<ResultRatingHistory>?> fetchRatingHistory(String handle) => throw UnimplementedError();
  @override
  Future<List<ResultContestList>?> fetchContestList() => throw UnimplementedError();
}

class ResultUser {
  String? firstName;
  String? lastName;
  String? country;
  late int contribution;
  String? rank;
  int? rating;
  String? maxRank;
  int? maxRating;
  late int lastOnlineTimeSeconds;
  late int registrationTimeSeconds;
  late int friendOfCount;
  late String avatar;
  late String titlePhoto;

  ResultUser({
    this.firstName,
    this.lastName,
    this.country,
    required this.contribution,
    this.rank,
    this.rating,
    this.maxRank,
    this.maxRating,
    required this.lastOnlineTimeSeconds,
    required this.registrationTimeSeconds,
    required this.friendOfCount,
    required this.avatar,
    required this.titlePhoto,
  });

  String get getFirstName => firstName ?? "";
  String get getLastName => lastName ?? "";
  String get getCountry => country ?? "";
  String get getContribution => "$contribution";
  String get getRank => rank ?? "";
  String get getRating => rating == null ? "" : "$rating";
  String get getMaxRank => maxRank ?? "";
  String get getMaxRating => rating == null ? "" : "$maxRating";
  String get getFriendOfCount => "$friendOfCount";
  String get getLastOnlineTimeSeconds => getFormattedTime(lastOnlineTimeSeconds);
  String get getRegistrationTimeSeconds => getFormattedTime(registrationTimeSeconds);
  String get getAvatar => avatar;
  String get getTitlePhoto => titlePhoto;

  String getFormattedTime(int unixTimestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }

  ResultUser.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    country = json['country'];
    contribution = json['contribution'];
    rank = json['rank'];
    rating = json['rating'];
    maxRank = json['maxRank'];
    maxRating = json['maxRating'];
    lastOnlineTimeSeconds = json['lastOnlineTimeSeconds'];
    registrationTimeSeconds = json['registrationTimeSeconds'];
    friendOfCount = json['friendOfCount'];
    avatar = json['avatar'];
    titlePhoto = json['titlePhoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['country'] = country;
    data['contribution'] = contribution;
    data['rank'] = rank;
    data['rating'] = rating;
    data['maxRank'] = maxRank;
    data['maxRating'] = maxRating;
    data['lastOnlineTimeSeconds'] = lastOnlineTimeSeconds;
    data['registrationTimeSeconds'] = registrationTimeSeconds;
    data['friendOfCount'] = friendOfCount;
    data['avatar'] = avatar;
    data['titlePhoto'] = titlePhoto;
    return data;
  }
}