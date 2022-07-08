import 'package:chess_flutter/domain/entity/credential_entity.dart';
import 'package:chess_flutter/feature/auth/bloc/auth_cubit.dart';
import 'package:chess_flutter/feature/auth/bloc/auth_state.dart';
import 'package:chess_flutter/feature/auth/widget/auth_confirm_button_widget.dart';
import 'package:chess_flutter/feature/auth/widget/auth_input_field.dart';
import 'package:chess_flutter/models/enums/auth_type.dart';
import 'package:chess_flutter/models/register_credential.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common_widgets/cw_text.dart';
import '../../../models/enums/auth_filed_type.dart';

class StringWrapper {
  AuthFiledType filed;
  String value;
  String hint;
  IconData icon;
  Function? validaton;
  String guideText;
  String labelText;
  StringWrapper({
    required this.filed,
    required this.value,
    required this.hint,
    required this.icon,
    this.validaton,
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
  late CredentialEntity credentialEntity;
  final formKey = GlobalKey<FormState>();

  late StringWrapper nameWrapper;
  late StringWrapper emailWrapper;
  late StringWrapper passwordWrapper;
  late StringWrapper confrimPasswordWrapper;

  void initializeStringWrappers() {
    nameWrapper = StringWrapper(
      filed: AuthFiledType.username,
      value: '',
      hint: 'username',
      icon: Icons.verified_user,
      labelText: "username",
      guideText: "نام کاربری",
    );
    emailWrapper = StringWrapper(
      filed: AuthFiledType.email,
      value: '',
      hint: 'google.site@gmail.com',
      icon: Icons.email,
      labelText: "email",
      guideText: "ایمیل",
    );
    passwordWrapper = StringWrapper(
      filed: AuthFiledType.password,
      value: '',
      hint: 'SnGoogle4321',
      icon: Icons.lock,
      labelText: "password",
      guideText: "رمز شامل حروف یزرگ و کوچک و اعداد باشد و طول آن حداقل 8 باشد",
    );
    confrimPasswordWrapper = StringWrapper(
      filed: AuthFiledType.confirmPassword,
      value: '',
      hint: 'SnGoogle4321',
      icon: Icons.lock,
      labelText: "confirm password",
      guideText: "مطابق رمز بالا باشد",
    );
  }

  @override
  void initState() {
    super.initState();
    initializeStringWrappers();
    credentialEntity = CredentialEntity(
      nameWrapper.value,
      emailWrapper.value,
      passwordWrapper.value,
      confrimPasswordWrapper.value,
      widget.authType,
    );
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
            onChanged: () {
              credentialEntity.username = nameWrapper.value;
              credentialEntity.email = emailWrapper.value;
              credentialEntity.password = passwordWrapper.value;
              credentialEntity.confirmPassword = confrimPasswordWrapper.value;
            },
            child: Column(
              children: [
                //
                if (widget.authType == AuthType.signup)
                  AuthInputField(
                    inputValue: nameWrapper,
                    credentialEntity: credentialEntity,
                    key: Key(nameWrapper.labelText),
                  ),
                if (widget.authType == AuthType.signup)
                  const SizedBox(height: 10),
                //
                AuthInputField(
                  inputValue: emailWrapper,
                  credentialEntity: credentialEntity,
                  key: Key(emailWrapper.labelText),
                ),
                const SizedBox(height: 10),
                //
                AuthInputField(
                  inputValue: passwordWrapper,
                  credentialEntity: credentialEntity,
                  key: Key(passwordWrapper.labelText),
                ),
                //
                if (widget.authType == AuthType.signup)
                  const SizedBox(height: 10),
                if (widget.authType == AuthType.signup)
                  AuthInputField(
                    inputValue: confrimPasswordWrapper,
                    credentialEntity: credentialEntity,
                    key: Key(confrimPasswordWrapper.labelText),
                  ),
                //
                const SizedBox(height: 40),
                BlocBuilder<AuthCubit, AuthState>(
                    buildWhen: (previous, current) {
                  if (current is FormValidationAuthState) {
                    return true;
                  }
                  return false;
                }, builder: (context, state) {
                  // bool isFormValid = isFormValidate(widget.authType);
                  bool isFormValid = false;
                  if (state is FormValidationAuthState) {
                    isFormValid = state.isValid;
                  }

                  return AuthConfirmButtonWidget(
                    authType: widget.authType,
                    isFormValid: isFormValid,
                    credentialEntity: credentialEntity,
                  );
                }),
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
              nameWrapper.setValue("");
              confrimPasswordWrapper.setValue("");
              credentialEntity.confirmPassword = '';
              credentialEntity.authType =
                  authType == AuthType.login ? AuthType.signup : AuthType.login;
              BlocProvider.of<AuthCubit>(context)
                  .authTypePressedEvent(credentialEntity);
            },
            child: Text(authType == AuthType.login ? 'sign up' : 'login'),
          )
        ],
      ),
    );
  }
}
