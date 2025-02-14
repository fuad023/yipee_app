import 'package:flutter/material.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/api/codeforces_api.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/api/codeforces_contest_list.dart';

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
      backgroundColor: const Color(0xFFF7F7F7),
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
          return _contestBubble(
            name: _dataList[index].getName(),
            duration: _dataList[index].getDuration(),
            staringTime: _dataList[index].getStartTime(),
          );
        }
      ),
    );
  }

  Widget _contestBubble({
    required String name,
    required String duration,
    required String staringTime,
  }) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              // spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _myText(name, true),
                  _myText("Duration: $duration", false),
                  const SizedBox(height: 16.0),
                  Center(child: _myText(staringTime, true)),
                ],
              ),
            ),
          ],
        ),
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