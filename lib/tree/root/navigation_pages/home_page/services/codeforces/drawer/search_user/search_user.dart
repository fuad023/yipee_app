import 'package:flutter/material.dart';
import 'package:student_app/tree/root/drawer_section/manage_account/components/my_input_theme.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/drawer/search_user/public.dart';

import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/api/codeforces_api.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/api/codeforces_user.dart';

class SearchUser extends StatefulWidget {  
  const SearchUser({super.key});

  @override
  State<SearchUser> createState() => _AppbarActionState();
}

class _AppbarActionState extends State<SearchUser> {
  final TextEditingController _handleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final inputTheme = MyInputTheme().theme();

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
      backgroundColor: const Color(0xFFF7F7F7),

      appBar: AppBar(
        title: const Text("Search User"),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.green[700],
      ),

      body: isValidating 
      ? const Center(
        child: CircularProgressIndicator(
          color: Colors.green,
        )
      ) 
      : Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Form(
            key: _formKey,
            child: Row(
              children: [
                Expanded(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      textSelectionTheme: TextSelectionThemeData(
                        cursorColor: Colors.green[700],
                        selectionColor: Colors.green[200],
                        selectionHandleColor: Colors.green[700],
                      ),
                    ),
                    child: TextFormField(
                      controller: _handleController,
                      // autofocus: true,
                      decoration: const InputDecoration(
                        helperText: "",
                        hintText: "fuad023",
                        filled: true,
                        fillColor: Colors.white
                      ).applyDefaults(inputTheme),
                      validator: (value) {
                        if (value == null || value == "") {
                          return "Enter a valid name!";
                        } return null;
                      },
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  margin:  const EdgeInsets.only(left: 12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          spreadRadius: 4,
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: IconButton(
                      color: Colors.white,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          checkValidity(context);
                        }
                      },
                      icon: const Icon(Icons.search_rounded)
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}