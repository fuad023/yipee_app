import 'package:flutter/material.dart';

class ActiveTextfield extends StatefulWidget {
  final String labelText;
  final bool obsecureText;
  const ActiveTextfield({
    super.key,
    required this.labelText,
    required this.obsecureText
  });

  @override
  State<ActiveTextfield> createState() => _ActiveTextfieldState();
}

class _ActiveTextfieldState extends State<ActiveTextfield> {
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late bool _obsecureText;

  @override
  void initState() {
    super.initState();

    _obsecureText = widget.obsecureText;

    //reset afterloosing focus 
    _focusNode.addListener(() {
      if(!_focusNode.hasFocus) {
        setState(() {
          _obsecureText = true;
        });
      }
    });

    // Show suffix icon based on text field status at run time
    _passwordController.addListener(() {
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: _passwordController,
                  obscureText: _obsecureText,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    label: Text(
                      widget.labelText,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                    ),
                    prefixIcon: const Icon(Icons.key_off),
                    suffixIcon: _passwordController.text.isEmpty
                    ? null
                    : _obsecureText 
                    ? InkWell(
                      onTap: () => setState(() {
                        _obsecureText = false;
                      }),
                      child: const Icon(Icons.visibility)
                    )
                      : InkWell(
                      onTap: () => setState(() {
                        _obsecureText = true;
                      }),
                      child: const Icon(Icons.visibility_off)
                    ),
                  ),
                ),
              );
  }
}