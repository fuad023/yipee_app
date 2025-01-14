import 'package:flutter/material.dart';

class UserRatingHistory extends StatefulWidget {
  final String handle;

  const UserRatingHistory({
    super.key,
    required this.handle,
  });

  @override
  State<UserRatingHistory> createState() => _UserRatingHistoryState();
}

class _UserRatingHistoryState extends State<UserRatingHistory> {late String handle;
  bool dataFetching = false;

  void fetchSubmissions(String handle) async {

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
    : const Center(
      child: Text("User Rating History"),
    );
  }
}