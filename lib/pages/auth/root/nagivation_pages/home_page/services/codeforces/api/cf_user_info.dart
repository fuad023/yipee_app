import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/api/codeforces_api.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class CfGetUserInfo extends CodeforcesApi {
  
  late String status;
  late int contribution;
  late String lastOnlineTimeSeconds;
  late int friendOfCount;
  late String titlePhoto;
  String handle;
  late String avatar;
  late String registrationTimeSeconds;

  CfGetUserInfo({
    required this.handle,
  });

  String getFormattedTime(int unixTimestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }

  @override
  Future<CfUserInfo?> getUserInfo() async {
    try {
      Response response = await get(Uri.parse("${baseURL}user.info?handles=$handle"));
      Map<String, dynamic> data = jsonDecode(response.body);

      if (data["status"] == "FAILED") {
        throw Exception(data["comment"]);
      } else if (data["status"] == "OK") {

        contribution            = data["result"][0]["contribution"];
        lastOnlineTimeSeconds   = getFormattedTime(data["result"][0]["lastOnlineTimeSeconds"]);
        friendOfCount           = data["result"][0]["friendOfCount"];
        titlePhoto              = data["result"][0]["titlePhoto"];
        avatar                  = data["result"][0]["avatar"];
        registrationTimeSeconds = getFormattedTime(data["result"][0]["registrationTimeSeconds"]);

      }

      return CfUserInfo(
        contribution: contribution,
        lastOnlineTimeSeconds: lastOnlineTimeSeconds,
        friendOfCount: friendOfCount,
        titlePhoto: titlePhoto,
        handle: handle, avatar: avatar,
        registrationTimeSeconds: registrationTimeSeconds,
      );
    } catch (e) {
      print('Caught an error in UserInfo class: $e'); // ignore: avoid_print
      return null;
    }
  }
}

class CfUserInfo {
  int contribution;
  String lastOnlineTimeSeconds;
  int friendOfCount;
  String titlePhoto;
  String handle;
  String avatar;
  String registrationTimeSeconds;

  CfUserInfo({
    required this.contribution,
    required this.lastOnlineTimeSeconds,
    required this.friendOfCount,
    required this.titlePhoto,
    required this.handle,
    required this.avatar,
    required this.registrationTimeSeconds,
  });

  Map<String, dynamic> toMap() => <String, dynamic> {
      "contribution": contribution,
      "lastOnlineTimeSeconds": lastOnlineTimeSeconds,
      "friendOfCount": friendOfCount,
      "titlePhoto": titlePhoto,
      "handle": handle,
      "avatar": avatar,
      "registrationTimeSeconds": registrationTimeSeconds,
    };
}