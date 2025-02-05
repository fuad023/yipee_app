import 'package:flutter/material.dart';

class RemastaredTextField extends StatefulWidget {
  final String labelText;
  final bool isobsecureText;
  final TextEditingController controller;
  final bool prefixIconForOtherInput;
  const RemastaredTextField({
    super.key,
    required this.labelText,
    required this.isobsecureText,
    required this.controller,
    required this.prefixIconForOtherInput
  });

  @override
  State<RemastaredTextField> createState() => _ActiveTextfieldState();
}

class _ActiveTextfieldState extends State<RemastaredTextField> {
  final FocusNode _focusNode = FocusNode();
  late bool _obsecureText;

  @override
  void initState() {
    super.initState();

    _obsecureText = widget.isobsecureText;

    //reset afterloosing focus 
    _focusNode.addListener(() {
      if(!_focusNode.hasFocus) {
        setState(() {
          _obsecureText = widget.isobsecureText;
        });
      }
    });

    // Show suffix icon based on text field status at run time
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: widget.controller,
                  obscureText: widget.isobsecureText ? _obsecureText : false,
                  focusNode: _focusNode,
                    onChanged: (text) {
                      setState(() {}); // Ensures clear icon updates instantly
                    },
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
                    prefixIcon: widget.isobsecureText
                    ? const Icon(Icons.key_off)
                    : widget.prefixIconForOtherInput
                      ? const Icon(Icons.confirmation_num)
                      : const Icon(Icons.email_sharp),
                    suffixIcon: widget.isobsecureText
                      ? 
                        widget.controller.text.isEmpty
                          ? null
                          : _obsecureText 
                            ? InkWell(
                              onTap: () => setState(() {
                              _obsecureText = !_obsecureText;
                              }),
                              child: const Icon(Icons.visibility)
                              )
                            : InkWell(
                                onTap: () => setState(() {
                                _obsecureText = !_obsecureText;
                                }),
                                child: const Icon(Icons.visibility_off)
                                )
                      : widget.controller.text.isEmpty
                          ? null
                          : InkWell(
                              onTap: () {
                              widget.controller.clear();
                              setState(() {});
                              },
                              child: const Icon(Icons.clear)
                               )
                  ),
                  style: const TextStyle(
                    color: Colors.black
                  ),
                ),
              );
  }
}