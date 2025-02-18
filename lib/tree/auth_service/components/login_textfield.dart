import 'package:flutter/material.dart';

class LoginTextfield extends StatefulWidget {
  final TextEditingController controlText;
  final FocusNode focusNode;
  final bool secureText;
  final String hitText;
  

  const LoginTextfield({
    super.key,
    required this.controlText,
    required this.secureText,
    required this.hitText,
    required this.focusNode,
  });

  @override
  State<LoginTextfield> createState() => _LoginTextfieldState();
}

class _LoginTextfieldState extends State<LoginTextfield> {
  late bool _isSecureText;

  @override
  void initState() {
    super.initState();
    _isSecureText = widget.secureText;

    widget.controlText.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    bool hasText = widget.controlText.text.isNotEmpty;

    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.8,
      child: TextFormField(
        controller: widget.controlText,
        obscureText: widget.secureText && _isSecureText,
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
                          _isSecureText = !_isSecureText;
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
                        widget.controlText.clear();
                        setState(
                            () {});
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
