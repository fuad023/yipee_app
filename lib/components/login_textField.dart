import 'package:flutter/material.dart';

class LoginTextField extends StatefulWidget {
  final TextEditingController controlText;
  final FocusNode focusNode;
  final bool secureText; // Indicates if the field is for passwords
  final String hitText;
  

  const LoginTextField({
    super.key,
    required this.controlText,
    required this.secureText,
    required this.hitText,
    required this.focusNode,
  });

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  late bool _isSecureText; // Internal state to manage visibility

  @override
  void initState() {
    super.initState();
    _isSecureText = widget.secureText; // Initialize based on secureText
    // Listen for changes in text
    widget.controlText.addListener(() {
      setState(() {}); // Trigger rebuild to update icon visibility
    });
  }

  @override
  Widget build(BuildContext context) {
    bool hasText = widget.controlText.text.isNotEmpty; // Check if there's text

    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.8,
      child: TextFormField(
        controller: widget.controlText,
        obscureText: widget.secureText && _isSecureText, // Toggle visibility
        autofocus: false,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          isDense: true,
          hintText: widget.hitText,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(24.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(24.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(24.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(24.0),
          ),
          prefixIcon: Icon(
            widget.secureText ? Icons.key_off : Icons.outgoing_mail,
            color: Colors.white,
          ),
          suffixIcon: widget.secureText
              ? (hasText
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          _isSecureText = !_isSecureText; // Toggle visibility
                        });
                      },
                      child: Icon(
                        _isSecureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white,
                        size: 22.0,
                      ),
                    )
                  : null)
              : (hasText
                  ? InkWell(
                      onTap: () {
                        widget.controlText.clear(); // Clear the text
                        setState(
                            () {}); // Trigger state update to hide the icon
                      },
                      child: const Icon(
                        Icons.clear,
                        color: Colors.white,
                        size: 22.0,
                      ),
                    )
                  : null),
        ),
        keyboardType: widget.secureText
            ? TextInputType.visiblePassword
            : TextInputType.emailAddress,
        cursorColor: Colors.white54,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
