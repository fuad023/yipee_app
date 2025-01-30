import 'package:flutter/material.dart';
import 'package:student_app/pages/root/navigation_pages/home_page/services/codeforces/api/codeforces_api.dart';
import 'package:student_app/pages/root/navigation_pages/home_page/services/codeforces/api/codeforces_contest_list.dart';

class ContestList extends StatefulWidget {
  const ContestList({super.key});

  @override
  State<ContestList> createState() => _ContestListState();
}

class _ContestListState extends State<ContestList> {
  bool _dataFetching = true;
  final CodeforcesApi _codeforcesApi = CodeforcesContestList();
  List<ResultContestList> _dataList = [];

  void _fetchContestList() async {
    try {
      _dataList = (await _codeforcesApi.fetchContestList())!;
      if (!mounted) return;

      setState(() {
        _dataFetching = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _dataFetching = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: const Text("Upcoming Contests"),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.green[700],
      ),
      body: _showContestList(),
    );
  }

  Widget _showContestList() {
    if (_dataFetching) {
      _fetchContestList();
    }

    return _dataFetching
    ? Center(
      child: CircularProgressIndicator(
        color: Colors.green[700],
      ),
    )
    : _dataList.isEmpty
    ? const Center(
      child: Text("No nearby contest available :("),
    )
    : Scrollbar(
      interactive: true,
      thickness: 8.0,
      radius: const Radius.circular(8.0),
      child: ListView.builder(
        itemCount: _dataList.length,
        itemBuilder: (context, index) {
          return Center(
            child: Column(
              children: [
                ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _myText(_dataList[index].getName(), true),
                      _myText("Duration: ${_dataList[index].getDuration()}", false),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      _myText(_dataList[index].getStartTime(), true),
                      Divider(color: Colors.green[700],),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }

  Widget _myText(String text, bool bold) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        fontSize: 12.0
      ),
    );
  }
}