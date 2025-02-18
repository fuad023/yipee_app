import 'package:flutter/material.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/navigation_pages/components/text_components.dart';

import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/api/codeforces_api.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/api/codeforces_submissions.dart';

class Submissions extends StatefulWidget {
  final String? handle;

  const Submissions({
    super.key,
    required this.handle,
  });

  @override
  State<Submissions> createState() => _SubmissionsState();
}

class _SubmissionsState extends State<Submissions> {
  String? _handle;
  bool _dataFetching = true;
  final CodeforcesApi _codeforcesApi = CodeforcesSubmissions();
  List<ResultSubmissions> _dataList = [];

  void fetchSubmissions(String handle) async {
    try {
      _dataList = (await _codeforcesApi.fetchSubmissions(handle))!;
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
    ? const Center(
      child: CircularProgressIndicator(
        color: Colors.green,
      ),
    )
    : _dataList.isEmpty
    ? const Center(
      child: Text("Haven't made any submission yet?"),
    )
    : Scrollbar(
      interactive: true,
      thickness: 8.0,
      radius: const Radius.circular(8.0),
      child: ListView.builder(
        itemCount: _dataList.length,
        itemBuilder: (context, index) {
          return _submissionBubble(
            idName: _dataList[index].getIdName(),
            rating: _dataList[index].getRating(),
            participantType: _dataList[index].getParticipantType(),
            submitTime: _dataList[index].getCreatedWhen(),
            verdict: _dataList[index].getVerdict(),
          );
        }
      ),
    );
  }

  Widget _submissionBubble({
    required String idName,
    required String rating,
    required String participantType,
    required String submitTime,
    required String verdict,
  }) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05), // Shadow color
              spreadRadius: 2, // How much the shadow spreads
              blurRadius: 2,  // Softness of the shadow
              offset: const Offset(0, 2), // Position (X, Y)
            ),
          ],
        ),
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleText(value: idName, bold: true),
              DoubleText(type: "Rating: ", value: rating),
              DoubleText(type: "Participant: ", value: participantType),
              const SizedBox(height: 8.0),
              SingleText(value: submitTime, bold: false),
            ],
          ),
          trailing: setVerdict(verdict),
        ),
      ),
    );
  }

  Widget setVerdict(String verdict) {
    return Text(
      verdict,
      style: TextStyle(
        color: (verdict == "OK") ? Colors.green[700] : Colors.red,
      ),
    );
  }
}