import 'package:flutter/material.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/api/codeforces_api.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/api/codeforces_submissions.dart';

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
  final CodeforcesApi _codeforcesApi = CodeforcesSubmissions();
  List<ResultSubmissions> _dataList = [];

  void fetchSubmissions(String handle) async {
    try {
      _dataList = (await _codeforcesApi.fetchSubmissions(handle))!;
      if (!mounted) return;

      setState(() {
          dataFetching = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          dataFetching = false;
        });
      }
    }
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

    return dataFetching
    ? Center(
      child: CircularProgressIndicator(
        color: Colors.green[700],
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
          return Center(
            child: Column(
              children: [
                index == 0 ? const Padding(padding: EdgeInsets.all(4.0)) : Container(),
                ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _myText(_dataList[index].getIdName(), true),
                      _myTextTwo("Rating: ", _dataList[index].getRating()),
                      _myTextTwo("Participant: ", _dataList[index].getParticipantType()),
                      const SizedBox(height: 8.0),
                      _myText(_dataList[index].getCreatedWhen(), false),
                    ],
                  ),
                  trailing: setVerdict(_dataList[index].getVerdict()),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(color: Colors.green[700],),
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

  Widget setVerdict(String verdict) {
    return Text(
      verdict,
      style: TextStyle(
        color: (verdict == "OK") ? Colors.green[700] : Colors.red,
      ),
    );
  }
}