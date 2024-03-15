import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_manager/presentation/widgets/common_snackbar.dart';
import 'package:task_manager/presentation/widgets/svg_background_setter.dart';
import 'package:string_validator/string_validator.dart' as str;

class SetPasswordScreen extends StatefulWidget {
  final String otp;
  final String email;

  const SetPasswordScreen({super.key, required this.otp, required this.email});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
  TextEditingController();
  bool _isSetPasswordInProgress = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SvgBackgroundSetter(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 40, right: 30, top: 200),
            child: setPasswordForm(context),
          )),
    );
  }

  Form setPasswordForm(BuildContext context) {
    return Form(
      key: _formKey,
      child:
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Set Password',
          style: Theme
              .of(context)
              .textTheme
              .titleLarge,
        ),
        Text(
          'Minimum length password 8 character with latter and number combination',
          style: Theme
              .of(context)
              .textTheme
              .titleSmall,
        ),
        const SizedBox(height: 15),
        TextFormField(
          obscureText: _obscure,
          enabled: true,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Enter Password';
            }
            else if (value.length < 8) {
              return 'Password Length Should be 8 Character';
            }
            else {
              if (str.isAlpha(value) || str.isNumeric(value)) {
                return 'Digit And Latter Combination only' ;
              }
              return null;
            }
          },
          decoration: InputDecoration(
            hintText: 'Password',
            suffixIcon: IconButton(
                onPressed: () {
                  _obscure = _obscure ? _obscure = false : _obscure =
                  true;
                  setState(() {});
                },
                icon: Icon(_obscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined)),
          ),
          controller: _passwordTEController,
        ),
        TextFormField(
          enabled: true,
          validator: (String? value) {
            if (_passwordTEController.text == value) return null;
            return "Don't Match";
          },
          obscureText: _obscure,
          decoration: InputDecoration(
            hintText: 'Confirm Password', suffixIcon: IconButton(
              onPressed: () {
                _obscure ? _obscure = false : _obscure = true;
                setState(() {});
              },
              icon: Icon(_obscure
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined)),),
          controller: _confirmPasswordTEController,
        ),
        const SizedBox(height: 12),
        Visibility(
          visible: _isSetPasswordInProgress == false,
          replacement: const Center(child: CircularProgressIndicator()),
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                setPassword();
              }
            },
            child: const Icon(Symbols.expand_circle_right),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Have account?',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium),
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignIn()),
                        (route) => false);
              },
              child: const Text('Sign In'),
            )
          ],
        ),
      ]),
    );
  }

  Future<void> setPassword() async {
    _isSetPasswordInProgress = true;
    setState(() {});
    Map<String, dynamic>inputParams = {
      "email": widget.email,
      "OTP": widget.otp,
      "password": _passwordTEController.text
    };
    final response = await NetworkCaller.postRequest(
        Url.setPasswordUrl, inputParams);
    if (response.isSuccess) {
      _isSetPasswordInProgress = false;
      setState(() {});
      if (response.body['status'] == 'success') {
        if (mounted) {
          commonSnackBar(
              context: context, snackBarContent: 'Password Set Successfully');
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => const SignIn()), (
                  route) => false);
        }
      } else {
        if (mounted) {
          commonSnackBar(context: context,
              snackBarContent: response.body['data'],
              isErrorSnack: true);
        }
      }
    } else {
      _isSetPasswordInProgress = false;
      setState(() {});
      if (mounted) {
        commonSnackBar(context: context,
            snackBarContent: response.errorMassage ?? 'Error! Try Again');
      }
    }
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
