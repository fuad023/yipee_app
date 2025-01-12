import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/api/cf_user_info.dart';

abstract class CodeforcesApi {

  final String baseURL = "https://codeforces.com/api/";
  
  Future<CfUserInfo?> getUserInfo();
}