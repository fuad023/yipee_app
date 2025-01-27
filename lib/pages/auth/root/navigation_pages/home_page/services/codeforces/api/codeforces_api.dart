import 'package:student_app/pages/auth/root/navigation_pages/home_page/services/codeforces/api/codeforces_user.dart';
import 'package:student_app/pages/auth/root/navigation_pages/home_page/services/codeforces/api/codeforces_submissions.dart';
import 'package:student_app/pages/auth/root/navigation_pages/home_page/services/codeforces/api/codeforces_rating_history.dart';
import 'package:student_app/pages/auth/root/navigation_pages/home_page/services/codeforces/api/codeforces_contest_list.dart';

abstract class CodeforcesApi {
  final String baseURL = "https://codeforces.com/api/";

  Future<bool> checkValidity(String handle);
  Future<ResultUser?> fetchUser(String handle);
  Future<List<ResultSubmissions>?> fetchSubmissions(String handle);
  Future<List<ResultRatingHistory>?> fetchRatingHistory(String handle);
  Future<List<ResultContestList>?> fetchContestList();
}