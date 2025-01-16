import 'package:flutter/material.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/api/codeforces_api.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/api/codeforces_rating_history.dart';

class UserRatingHistory extends StatefulWidget {
  final String? handle;

  const UserRatingHistory({
    super.key,
    required this.handle,
  });

  @override
  State<UserRatingHistory> createState() => _UserRatingHistoryState();
}

class _UserRatingHistoryState extends State<UserRatingHistory> {
  String? _handle;
  bool _dataFetching = true;
  final CodeforcesApi _codeforcesApi = CodeforcesRatingHistory();
  List<ResultRatingHistory> _dataList = [];

  void fetchSubmissions(String handle) async {
    try {
      _dataList = (await _codeforcesApi.fetchRatingHistory(handle))!;
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
  void initState() {
    super.initState();
    _handle = widget.handle;
  }

  @override
  Widget build(BuildContext context) {
    return _handle == null ? _requestSetup() : _showSubmissions();
  }

  Widget _requestSetup() {
    return const Center(
      child: Text("Please setup handle name."),
    );
  }

  Widget _showSubmissions() {
    if (_dataFetching) {
      fetchSubmissions(_handle!);
    }

    return _dataFetching
    ? Center(
      child: CircularProgressIndicator(
        color: Colors.green[700],
      ),
    )
    : _dataList.isEmpty
    ? const Center(
      child: Text("Haven't participated in any contest yet?"),
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
                index == 0 ? const Padding(padding: EdgeInsets.all(4.0)) : Container(),
                ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _myText(_dataList[index].getContestName, true),
                      _myTextTwo("Rank: ", _dataList[index].getRank),
                      _myTextTwo("Updated Rating: ", _dataList[index].getNewRating),
                      _myTextTwo("Update Time: ", _dataList[index].getRatingUpdateTimeSeconds),
                    ],
                  ),
                  trailing: _setRatingDiff(_dataList[index].getRatingDiff),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(color: Colors.green[700],),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _myText(String text, bool bold) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        fontSize: 10.0
      ),
    );
  }

  Widget _myTextTwo(String text, String key) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 10.0
          ),
        ),
        Text(
          key,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 10.0
          ),
        ),
      ],
    );
  }

  Widget _setRatingDiff(int diff) {
    return Text(
      diff < 0 ? "$diff" : "+$diff",
      style: TextStyle(
        color: (diff < 0) ? Colors.red : Colors.green[600],
      ),
    );
  }
}