import 'package:flutter/material.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/navigation_pages/components/text_components.dart';

import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/api/codeforces_api.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/api/codeforces_rating_history.dart';

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
    return _handle == null ? _requestSetup() : _showRatingHistory();
  }

  Widget _requestSetup() {
    return const Center(
      child: Text("Please setup handle name."),
    );
  }

  Widget _showRatingHistory() {
    if (_dataFetching) {
      fetchSubmissions(_handle!);
    }

    return _dataFetching
    ? const Center(
      child: CircularProgressIndicator(
        color: Colors.green,
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
          return _ratingHistoryBubble(
            contestName: _dataList[index].getContestName,
            rank: _dataList[index].getRank,
            newRating: _dataList[index].getNewRating,
            ratingUpdateTime: _dataList[index].getRatingUpdateTimeSeconds,
            ratingDifference: _dataList[index].getRatingDiff,
          );
        },
      ),
    );
  }

  Widget _ratingHistoryBubble({
    required String contestName,
    required String rank,
    required String newRating,
    required String ratingUpdateTime,
    required int ratingDifference,
  }) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              // spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleText(value: contestName, bold: true),
              DoubleText(type: "Rank: ", value: rank),
              DoubleText(type: "Updated Rating: ", value: newRating),
              DoubleText(type: "Update Time: ", value: ratingUpdateTime),
            ],
          ),
          trailing: _setRatingDiff(ratingDifference),
        ),
      ),
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