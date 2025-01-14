import 'package:flutter/material.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/navigation_pages/api/codeforces_api.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/navigation_pages/api/codeforces_contest_list.dart';

class ContestList extends StatefulWidget {
  const ContestList({super.key});

  @override
  State<ContestList> createState() => _ContestListState();
}

class _ContestListState extends State<ContestList> {
  late bool dataFetching = true;
  final CodeforcesApi _codeforcesApi = CodeforcesContestList();
  List<ResultContestList> _dataList = [];

  void _fetchContestList() async {
    try {
      await _codeforcesApi.fetchContestList();
      if (!mounted) return;

      // setState(() {
      //     dataFetching = false;
      // });
    } catch (e) {
      // if (mounted) {
      //   setState(() {
      //     dataFetching = false;
      //   });
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _showContestList();
  }

  Widget _showContestList() {
    if (dataFetching) {
      _fetchContestList();
    }

    return dataFetching
    ? Center(
      child: CircularProgressIndicator(
        color: Colors.green[700],
      ),
    )
    : ListView.builder(
      itemCount: _dataList.length,
      itemBuilder: (context, index) {
        return const Center(
          child: Column(
            children: [
              ListTile(
                leading: Text("Sample Text"),
              )
            ],
          ),
        );
      }
    )
    ;
  }
}