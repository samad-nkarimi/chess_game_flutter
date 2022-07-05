import 'package:chess_flutter/domain/entity/credential_entity.dart';
import 'package:chess_flutter/feature/auth/bloc/auth_cubit.dart';
import 'package:chess_flutter/feature/auth/bloc/auth_state.dart';
import 'package:chess_flutter/models/enums/auth_filed_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common_widgets/cw_text.dart';
import 'auth_content_widget.dart';

class AuthInputField extends StatefulWidget {
  final StringWrapper inputValue;
  final CredentialEntity credentialEntity;
  const AuthInputField(
      {Key? key, required this.inputValue, required this.credentialEntity})
      : super(key: key);

  @override
  State<AuthInputField> createState() => _AuthInputFieldState();
}

class _AuthInputFieldState extends State<AuthInputField> {
  // bool isValid = false;
  bool focus = false;
  FocusNode f = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(buildWhen: (previous, current) {
      if (current is FiledValidationAuthState) {
        if (current.filedType == widget.inputValue.filed) {
          return true;
        }
      }
      return false;
    }, builder: (context, state) {
      bool isValid = false;
      if (state is FiledValidationAuthState) {
        isValid = state.isValid;
      }
      print(state);
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 40,
              child: TextFormField(
                onChanged: (value) {
                  switch (widget.inputValue.filed) {
                    case AuthFiledType.username:
                      widget.credentialEntity.username = value;
                      break;
                    case AuthFiledType.email:
                      widget.credentialEntity.email = value;
                      break;
                    case AuthFiledType.password:
                      widget.credentialEntity.password = value;
                      break;
                    case AuthFiledType.confirmPassword:
                      widget.credentialEntity.confirmPassword = value;
                      break;

                    default:
                  }
                  BlocProvider.of<AuthCubit>(context).formContentChanged(
                      widget.inputValue.filed, widget.credentialEntity);
                  widget.inputValue.setValue(value);

                  // if (widget.inputValue.validaton(value)) {
                  //   isValid = true;
                  // } else {
                  //   isValid = false;
                  // }
                  // setState(() {});
                },
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return "enter password";
                  // }
                  // return null;
                  // if (widget.inputValue.validaton(value)) {
                  //   return null;
                  // } else {
                  //   return "bad input";
                  // }
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
                  fillColor:
                      focus ? Color.fromARGB(250, 250, 250, 251) : Colors.white,
                  // errorText: "error",
                  filled: true,
                  // focusColor: onEmail ? Colors.red : Colors.white,

                  prefixIcon: Icon(
                    widget.inputValue.icon,
                    color: Color.fromARGB(255, 76, 164, 214),
                    size: 20.0,
                  ),
                  prefixIconColor: Color.fromARGB(255, 32, 128, 184),
                  suffixIcon: isValid
                      ? const Icon(
                          Icons.timeline,
                          color: Colors.green,
                        )
                      : null,
                  // labelText: "email",

                  label: Container(
                    // height: 10,
                    margin: EdgeInsets.all(0),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color.fromARGB(250, 250, 250, 251),
                    ),
                    child: Text(widget.inputValue.labelText),
                  ),
                  labelStyle:
                      const TextStyle(color: Color.fromARGB(166, 76, 175, 79)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black38,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                      color: Colors.black12,
                      width: .5,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CWText(
                widget.inputValue.guideText,
                fontSize: 10,
                color: Colors.black54,
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      );
    });
  }
}
