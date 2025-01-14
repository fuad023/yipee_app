import 'package:flutter/material.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/navigation_pages/api/codeforces_api.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/navigation_pages/api/codeforces_submissions.dart';

class Submissions extends StatefulWidget {
  final String handle;

  const Submissions({
    super.key,
    required this.handle,
  });

  @override
  State<Submissions> createState() => _SubmissionsState();
}

class _SubmissionsState extends State<Submissions> {
  late String handle;
  bool dataFetching = true;
  bool dataFetched = false;
  final CodeforcesApi _codeforcesApi = CodeforcesSubmissions();
  // late CodeforcesSubmissions _codeforcesSubmissions;

  void fetchSubmissions(String handle) async {
    await _codeforcesApi.fetchSubmissions(handle);
    dataFetching = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    handle = widget.handle;
    return handle.isEmpty ? _requestSetup() : _showSubmissions();
  }

  Widget _requestSetup() {
    return const Center(
      child: Text("Please setup handle name."),
    );
  }

  Widget _showSubmissions() {
    if (dataFetching) {
      fetchSubmissions(handle);
    }

    return const Center(
      child: Text("Please setup handle name."),
    );
  }
}