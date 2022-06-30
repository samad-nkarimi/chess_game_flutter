import 'package:flutter/material.dart';

import '../../../common_widgets/cw_text.dart';
import '../screen/auth_screen.dart';
import 'auth_content_widget.dart';

class AuthInputField extends StatefulWidget {
  final StringWrapper inputValue;
  const AuthInputField({Key? key, required this.inputValue}) : super(key: key);

  @override
  State<AuthInputField> createState() => _AuthInputFieldState();
}

class _AuthInputFieldState extends State<AuthInputField> {
  bool isValid = false;
  bool focus = false;
  FocusNode f = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextFormField(
            onChanged: (value) {
              widget.inputValue.setValue(value);

              if (widget.inputValue.validaton(value)) {
                isValid = true;
              } else {
                isValid = false;
              }
              setState(() {});
            },
            validator: (value) {
              // if (value == null || value.isEmpty) {
              //   return "enter password";
              // }
              // return null;
              if (widget.inputValue.validaton(value)) {
                return null;
              } else {
                return "bad input";
              }
            },
            onSaved: (value) {
              widget.inputValue.setValue(value!);
            },
            onTap: () {
              setState(() {
                focus = true;
              });
            },
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: widget.inputValue.hint,
              hintStyle: TextStyle(color: Colors.grey.withOpacity(.4)),
              fillColor: focus ? Colors.grey.shade200 : Colors.white,
              // errorText: "error",
              filled: true,
              // focusColor: onEmail ? Colors.red : Colors.white,

              prefixIcon: Icon(widget.inputValue.icon, color: Colors.amber),
              prefixIconColor: Colors.amber,
              suffixIcon: isValid
                  ? const Icon(
                      Icons.timeline,
                      color: Colors.green,
                    )
                  : null,
              // labelText: "email",

              // label: Container(
              //   // height: 10,
              //   child: const Text("email"),

              //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(30),
              //     color: Colors.white,
              //   ),
              // ),
              labelStyle: const TextStyle(color: Colors.green),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.green,
                  width: 2.5,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(32)),
                borderSide: BorderSide(
                  color: Colors.orange.shade100,
                  width: 1.5,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: CWText(
              widget.inputValue.guideText,
              fontSize: 10,
              color: Colors.red,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
