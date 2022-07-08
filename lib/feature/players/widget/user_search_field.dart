import 'dart:async';

import 'package:chess_flutter/feature/players/bloc/user_cubit.dart';
import 'package:chess_flutter/feature/players/utils/search_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserSearchField extends StatefulWidget {
  // final StringWrapper inputValue;
  const UserSearchField({Key? key}) : super(key: key);

  @override
  State<UserSearchField> createState() => _UserSearchFieldState();
}

class _UserSearchFieldState extends State<UserSearchField> {
  bool isValid = false;
  bool focus = false;
  FocusNode f = FocusNode();
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 1), () {});
  }

  @override
  Widget build(BuildContext context) {
    print("search field");
    return Container(
      child: TextFormField(
        onChanged: (value) {
          if (value.isEmpty) {
            SearchTimer(() {});
          } else {
            SearchTimer(
                () => BlocProvider.of<UserCubit>(context).searchForFeed(value));
          }

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
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintText: "@player_id",
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.4)),
          fillColor: focus
              ? const Color.fromARGB(255, 255, 255, 255)
              : const Color.fromARGB(139, 255, 255, 255),
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
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
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
