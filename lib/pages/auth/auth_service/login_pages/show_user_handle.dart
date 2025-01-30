import 'package:flutter/material.dart';
import 'package:student_app/pages/auth/auth_service/login_authentication/auth_services.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/yipee_chat/service/chat_service.dart';

class ShowUserHandle extends StatefulWidget {
  const ShowUserHandle({super.key});

  @override
  State<ShowUserHandle> createState() => _ShowUserHandleState();
}

class _ShowUserHandleState extends State<ShowUserHandle> {
  final Map<String, bool> isLoading = {};
  final ChatService _chatService = ChatService();
  final AuthServices _authServices = AuthServices();

  //Log in
  Future<void> signIn(BuildContext context,String email, pass) async {
    setState(() {
      isLoading[email] = true;
    });
    try {
      await _authServices.signInWithEmailAndPassword(email, pass);
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading[email] = false;
      });
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RootPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        // Error
        if (snapshot.hasError) {
          return const Text('Error');
        }

        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        // Return list
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    final bool loading = isLoading[userData['email']] ?? false;
    return GestureDetector(
      onTap: () {
        //_authServices.signOut();
        signIn(context, userData['email'], '12345678');
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0.5, 0, 0),
            child: Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.person_3_rounded),
                  ),
                  const SizedBox(width: 5,),
                  loading
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                  : Text(
                    userData['email'],
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10,)
        ],
      ),
    );
  }
}
