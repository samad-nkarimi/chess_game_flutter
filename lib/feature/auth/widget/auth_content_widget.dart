import 'package:chess_flutter/feature/auth/bloc/auth_cubit.dart';
import 'package:chess_flutter/feature/auth/widget/auth_confirm_button_widget.dart';
import 'package:chess_flutter/feature/auth/widget/auth_input_field.dart';
import 'package:chess_flutter/models/enums/auth_type.dart';
import 'package:chess_flutter/models/register_credential.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common_widgets/cw_text.dart';
import '../../players/widget/custom_input_field.dart';

class StringWrapper {
  String value;
  String hint;
  IconData icon;
  Function validaton;
  String guideText;
  StringWrapper(
      this.value, this.hint, this.icon, this.validaton, this.guideText);
  setValue(String value) {
    this.value = value;
  }
}

class AuthContentWidget extends StatefulWidget {
  final AuthType authType;
  AuthContentWidget({Key? key, this.authType = AuthType.signup})
      : super(key: key);

  @override
  State<AuthContentWidget> createState() => _AuthContentWidgetState();
}

class _AuthContentWidgetState extends State<AuthContentWidget> {
  final formKey = GlobalKey<FormState>();
  late StringWrapper emailWrapper;
  late StringWrapper passwordWrapper;
  late StringWrapper confrimPasswordWrapper;

  bool emailValidation(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  bool passwordValidation(String password) {
    if (password.length > 8 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[0-9]'))) {
      return true;
    } else {
      return false;
    }
  }

  bool confirmPasswordValidation(String value) {
    if (value == passwordWrapper.value && passwordValidation(value)) {
      return true;
    } else {
      return false;
    }
  }

  bool isFormValidate(AuthType authType) {
    if (emailValidation(emailWrapper.value) &&
        passwordValidation(passwordWrapper.value)) {
      if (authType == AuthType.signup) {
        return confirmPasswordValidation(confrimPasswordWrapper.value);
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    emailWrapper = StringWrapper(
        '', 'google.site@gmail.com', Icons.email, emailValidation, "ایمیل");
    passwordWrapper = StringWrapper(
        '',
        'SnGoogle4321',
        Icons.lock,
        passwordValidation,
        "رمز شامل حروف یزرگ و کوچک و اعداد باشد و طول آن حداقل 8 باشد");
    confrimPasswordWrapper = StringWrapper('', 'SnGoogle4321', Icons.lock,
        confirmPasswordValidation, "مطابق رمز بالا باشد");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 25, top: 10),
            child: CWText(
              widget.authType.name,
              color: Colors.amber,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                AuthInputField(inputValue: emailWrapper),
                const SizedBox(height: 10),
                AuthInputField(inputValue: passwordWrapper),
                if (widget.authType == AuthType.signup)
                  const SizedBox(height: 10),
                if (widget.authType == AuthType.signup)
                  AuthInputField(inputValue: confrimPasswordWrapper),
                const SizedBox(height: 40),
                AuthConfirmButtonWidget(
                  authType: widget.authType,
                  isFormValid: isFormValidate(widget.authType),
                  registerCredential: RegisterCredential(
                    "",
                    emailWrapper.value,
                    passwordWrapper.value,
                    widget.authType,
                  ),
                ),
                if (widget.authType == AuthType.login)
                  TextButton(
                    onPressed: () {},
                    child: const Text('forget password?'),
                  )
              ],
            ),
          ),
          const Spacer(),
          const Expanded(child: Divider(color: Colors.grey, height: 2)),
          bottomLine(context, widget.authType),
        ],
      ),
    );
  }

  Widget bottomLine(BuildContext context, AuthType authType) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            authType == AuthType.login
                ? 'don\'t you have account?'
                : 'already have accout?',
            style: const TextStyle(color: Colors.black),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<AuthCubit>(context).authTypePressedEvent(
                  authType == AuthType.login
                      ? AuthType.signup
                      : AuthType.login);
              print(authType);
            },
            child: Text(authType == AuthType.login ? 'sign up' : 'login'),
          )
        ],
      ),
    );
  }
}
