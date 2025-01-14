// ignore_for_file: unnecessary_null_comparison, prefer_if_null_operators

import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/api/codeforces_api.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/api/codeforces_contest_list.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/api/codeforces_submissions.dart';

class CfGetUserInfo extends CodeforcesApi {

  late CodeforcesUserInfo userInfo;
  
  late String status;
  late int contribution;
  late String lastOnlineTimeSeconds;
  late int friendOfCount;
  late String titlePhoto;
  late String handle;
  late String avatar;
  late String registrationTimeSeconds;

  String getFormattedTime(int unixTimestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }

  @override
  Future<void> setUserInfo(String handle) async {
    try {
      Response response = await get(Uri.parse("${baseURL}user.info?handles=$handle"));
      Map<String, dynamic> data = jsonDecode(response.body);

      if (data["status"] == "FAILED") {
        throw Exception(data["comment"]);
      } else if (data["status"] == "OK") {

        userInfo = CodeforcesUserInfo(
          contribution            : data["result"][0]["contribution"].toString(),
          lastOnlineTimeSeconds   : getFormattedTime(data["result"][0]["lastOnlineTimeSeconds"]),
          friendOfCount           : data["result"][0]["friendOfCount"].toString(),
          titlePhoto              : data["result"][0]["titlePhoto"],
          handle                  : data["result"][0]["handle"],
          avatar                  : data["result"][0]["avatar"],
          registrationTimeSeconds : getFormattedTime(data["result"][0]["registrationTimeSeconds"]),

          firstName               : data["result"][0]["firstName"],
          lastName                : data["result"][0]["lastName"],
          country                 : data["result"][0]["country"],
          rank                    : data["result"][0]["rank"],
          maxRank                 : data["result"][0]["maxRank"],
          rating                  : data["result"][0]["rating"].toString(),
          maxRating               : data["result"][0]["maxRating"].toString(),
        );
        userInfo.unNullify();
      }

    } catch (e) {
      print('Caught an error in UserInfo class: $e'); // ignore: avoid_print
    }
  }

  @override
  Future<bool> checkValidity(String handle) async {
    Response response = await get(Uri.parse("${baseURL}user.info?handles=$handle"));
    Map<String, dynamic> data = jsonDecode(response.body);

    return (data["status"] == "OK") ? true : false;
  }

  @override
  CodeforcesUserInfo getUserInfo() {
    return userInfo;
  }

  @override
  Future<List<ResultSubmissions>?> fetchSubmissions(String handle) { throw UnimplementedError(); }
  @override
  Future<List<ResultContestList>?> fetchContestList() { throw UnimplementedError(); }
}

class CodeforcesUserInfo {
  String contribution;
  String lastOnlineTimeSeconds;
  String friendOfCount;
  String titlePhoto;
  String handle;
  String avatar;
  String registrationTimeSeconds;

  String? firstName;
  String? lastName;
  String? country;
  String? rank;
  String? maxRank;
  String? rating;
  String? maxRating;

  CodeforcesUserInfo({
    required this.contribution,
    required this.lastOnlineTimeSeconds,
    required this.friendOfCount,
    required this.titlePhoto,
    required this.handle,
    required this.avatar,
    required this.registrationTimeSeconds,

    required this.firstName,
    required this.lastName,
    required this.country,
    required this.rank,
    required this.maxRank,
    required this.rating,
    required this.maxRating,

  });

  void unNullify() {
    contribution            = contribution == null            ? "" : contribution;
    lastOnlineTimeSeconds   = lastOnlineTimeSeconds == null   ? "" : lastOnlineTimeSeconds;
    friendOfCount           = friendOfCount == null           ? "" : friendOfCount;
    titlePhoto              = titlePhoto == null              ? "" : titlePhoto;
    handle                  = handle == null                  ? "" : handle;
    avatar                  = avatar == null                  ? "" : avatar;
    registrationTimeSeconds = registrationTimeSeconds == null ? "" : registrationTimeSeconds;

    firstName = firstName == null ? "" : firstName;
    lastName  = lastName == null  ? "" : lastName;
    country   = country == null   ? "" : country;
    rank      = rank == null      ? "" : rank;
    maxRank   = maxRank == null   ? "" : maxRank;
    rating    = (rating == null)    || (rating == "null")    ? "" : rating;
    maxRating = (maxRating == null) || (maxRating == "null") ? "" : maxRating;
  }
}