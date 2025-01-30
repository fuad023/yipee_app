import 'package:flutter/material.dart';
import 'package:student_app/pages/root/navigation_pages/home_page/services/codeforces/drawer/search_user/public.dart';
import 'package:student_app/pages/root/navigation_pages/home_page/services/codeforces/drawer/components/codeforces_textfield.dart';
import 'package:student_app/pages/root/navigation_pages/home_page/services/codeforces/drawer/components/codeforces_button.dart';

import 'package:student_app/pages/root/navigation_pages/home_page/services/codeforces/api/codeforces_api.dart';
import 'package:student_app/pages/root/navigation_pages/home_page/services/codeforces/api/codeforces_user.dart';

class SearchUser extends StatefulWidget {  

  const SearchUser({super.key});

  @override
  State<SearchUser> createState() => _AppbarActionState();
}

class _AppbarActionState extends State<SearchUser> {
  final TextEditingController _handleController = TextEditingController();

  bool isValidating = false;
  bool isValid = false;

  void checkValidity(BuildContext context) async {
    isValidating = true;
    setState(() {});
    CodeforcesApi codeforcesApi = CodeforcesUser();
    isValid = await codeforcesApi.checkValidity(_handleController.text);
    isValidating = false;
    if (!mounted) return;

    if (isValid) {
      // ignore: use_build_context_synchronously
      changeRoute(context);
    } else{
      _handleController.text = "handle doesn't exist";
      setState(() {});
    }
  }

  void changeRoute(BuildContext context) {
    FocusScope.of(context).unfocus();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Public(handle: _handleController.text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],

      appBar: AppBar(
        title: const Text("Search User"),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.green[700],
        elevation: 1.0,
      ),

      body: isValidating 
        ? const Center(
          child: CircularProgressIndicator(
            color: Colors.green,
          )
        ) 
        : Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 64.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CodeforcesTextfield(
                controller: _handleController,
                hintText: "handle",
                obscureText: false
              ),
              const SizedBox(height: 15.0),

              CodeforcesButton(
                text: "Search",
                onTap: () => checkValidity(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}