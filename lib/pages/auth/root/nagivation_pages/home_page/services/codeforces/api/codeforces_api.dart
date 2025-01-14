import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/api/cf_user_info.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/api/codeforces_submissions.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/api/codeforces_contest_list.dart';

abstract class CodeforcesApi {

  final String baseURL = "https://codeforces.com/api/";
  
  Future<void> setUserInfo(String handle);
  CodeforcesUserInfo getUserInfo();
  Future<bool> checkValidity(String handle);

  Future<List<ResultSubmissions>?> fetchSubmissions(String handle);
  Future<List<ResultContestList>?> fetchContestList();
}