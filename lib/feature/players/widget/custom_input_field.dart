import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  // final StringWrapper inputValue;
  const CustomInputField({Key? key}) : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool isValid = false;
  bool focus = false;
  FocusNode f = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        onChanged: (value) {
          // widget.inputValue.setValue(value);

          // if (widget.inputValue.validaton(value)) {
          //   isValid = true;
          // } else {
          //   isValid = false;
          // }
          // setState(() {});
        },
        validator: (value) {
          // if (widget.inputValue.validaton(value)) {
          //   return null;
          // } else {
          //   return "bad input";
          // }
        },
        onSaved: (value) {
          // widget.inputValue.setValue(value!);
        },
        onTap: () {
          setState(() {
            focus = true;
          });
        },
        style:
            const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          hintText: "@player_id",
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.4)),
          fillColor: focus
              ? Color.fromARGB(255, 255, 255, 255)
              : Color.fromARGB(139, 255, 255, 255),
          // errorText: "error",
          filled: true,
          // focusColor: onEmail ? Colors.red : Colors.white,

          prefixIconColor: Colors.amber,

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
              color: Colors.black54,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(32)),
            borderSide: BorderSide(
              color: Colors.black26,
              width: .5,
            ),
          ),
        ),
      ),
    );
  }
}
