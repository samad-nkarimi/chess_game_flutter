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
  String labelText;
  StringWrapper({
    required this.value,
    required this.hint,
    required this.icon,
    required this.validaton,
    required this.labelText,
    required this.guideText,
  });
  setValue(String value) {
    this.value = value;
  }
}

class AuthContentWidget extends StatefulWidget {
  final AuthType authType;
  const AuthContentWidget({Key? key, this.authType = AuthType.signup})
      : super(key: key);

  @override
  State<AuthContentWidget> createState() => _AuthContentWidgetState();
}

class _AuthContentWidgetState extends State<AuthContentWidget> {
  final formKey = GlobalKey<FormState>();

  late StringWrapper nameWrapper;
  late StringWrapper emailWrapper;
  late StringWrapper passwordWrapper;
  late StringWrapper confrimPasswordWrapper;

  bool nameValidation(String name) {
    return name.isNotEmpty && name.length < 20;
  }

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
        return nameValidation(nameWrapper.value) &&
            confirmPasswordValidation(confrimPasswordWrapper.value);
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  void initializeStringWrappers() {
    nameWrapper = StringWrapper(
      value: '',
      hint: 'username',
      icon: Icons.verified_user,
      validaton: nameValidation,
      labelText: "username",
      guideText: "نام کاربری",
    );
    emailWrapper = StringWrapper(
      value: '',
      hint: 'google.site@gmail.com',
      icon: Icons.email,
      validaton: emailValidation,
      labelText: "email",
      guideText: "ایمیل",
    );
    passwordWrapper = StringWrapper(
      value: '',
      hint: 'SnGoogle4321',
      icon: Icons.lock,
      validaton: passwordValidation,
      labelText: "password",
      guideText: "رمز شامل حروف یزرگ و کوچک و اعداد باشد و طول آن حداقل 8 باشد",
    );
    confrimPasswordWrapper = StringWrapper(
      value: '',
      hint: 'SnGoogle4321',
      icon: Icons.lock,
      validaton: confirmPasswordValidation,
      labelText: "confirm password",
      guideText: "مطابق رمز بالا باشد",
    );
  }

  @override
  void initState() {
    super.initState();
    initializeStringWrappers();
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
                //
                if (widget.authType == AuthType.signup)
                  AuthInputField(inputValue: nameWrapper),
                if (widget.authType == AuthType.signup)
                  const SizedBox(height: 10),
                //
                AuthInputField(inputValue: emailWrapper),
                const SizedBox(height: 10),
                //
                AuthInputField(inputValue: passwordWrapper),
                //
                if (widget.authType == AuthType.signup)
                  const SizedBox(height: 10),
                if (widget.authType == AuthType.signup)
                  AuthInputField(inputValue: confrimPasswordWrapper),
                //
                const SizedBox(height: 40),
                AuthConfirmButtonWidget(
                  authType: widget.authType,
                  isFormValid: isFormValidate(widget.authType),
                  registerCredential: RegisterCredential(
                    nameWrapper.value,
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
            },
            child: Text(authType == AuthType.login ? 'sign up' : 'login'),
          )
        ],
      ),
    );
  }
}
