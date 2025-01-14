import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/navigation_pages/api/cf_user_info.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/navigation_pages/api/codeforces_submissions.dart';

abstract class CodeforcesApi {

  final String baseURL = "https://codeforces.com/api/";
  
  Future<void> setUserInfo(String handle);
  CodeforcesUserInfo getUserInfo();
  Future<bool> checkValidity(String handle);

  Future<List<Result>?> fetchSubmissions(String handle);
}