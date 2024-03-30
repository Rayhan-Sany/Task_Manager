import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:task_manager/presentation/controllers/set_password_controller.dart';
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
  SetPasswordController setPasswordController =
      Get.find<SetPasswordController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Set Password',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          'Minimum length password 8 character with latter and number combination',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 15),
        GetBuilder<SetPasswordController>(builder: (setPasswordController) {
          return TextFormField(
            obscureText: setPasswordController.getObscure,
            enabled: true,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Enter Password';
              } else if (value.length < 8) {
                return 'Password Length Should be 8 Character';
              } else {
                if (str.isAlpha(value) || str.isNumeric(value)) {
                  return 'Digit And Latter Combination only';
                }
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: 'Password',
              suffixIcon: IconButton(
                  onPressed: () {

                    setPasswordController
                        .obscure(setPasswordController.getObscure);
                  },
                  icon: Icon(setPasswordController.getObscure
                      ? Icons.visibility_outlined
                      :Icons.visibility_off_outlined)),
            ),
            controller: _passwordTEController,
          );
        }),
        GetBuilder<SetPasswordController>(builder: (setPasswordController) {
          return TextFormField(
            enabled: true,
            validator: (String? value) {
              if (_passwordTEController.text == value) return null;
              return "Don't Match";
            },
            obscureText: setPasswordController.getObscure,
            decoration: InputDecoration(
              hintText: 'Confirm Password',
              suffixIcon: IconButton(
                  onPressed: () {
                    setPasswordController
                        .obscure(setPasswordController.getObscure);
                  },
                  icon: Icon(setPasswordController.getObscure
                      ? Icons.visibility_outlined
                      :Icons.visibility_off_outlined )),
            ),
            controller: _confirmPasswordTEController,
          );
        }),
        const SizedBox(height: 12),
        GetBuilder<SetPasswordController>(builder: (setPasswordController) {
          return Visibility(
            visible: setPasswordController.isSetPasswordInProgress == false,
            replacement: const Center(child: CircularProgressIndicator()),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setPassword();
                }
              },
              child: const Icon(Symbols.expand_circle_right),
            ),
          );
        }),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Have account?',
                style: Theme.of(context).textTheme.titleMedium),
            TextButton(
              onPressed: () {
                Get.offAll(const SignIn());
              },
              child: const Text('Sign In'),
            )
          ],
        ),
      ]),
    );
  }

  Future<void> setPassword() async {
    FocusScope.of(context).unfocus();
    Map<String, dynamic> inputParams = {
      "email": widget.email,
      "OTP": widget.otp,
      "password": _passwordTEController.text
    };
    final result = await setPasswordController.setPassword(inputParams);
    if (result) {
      if (mounted) {
        commonSnackBar(
            context: context, snackBarContent: 'Password Set Successfully');
        Get.offAll(const SignIn());
      }
    } else {
      if (mounted) {
        commonSnackBar(
            context: context,
            snackBarContent: setPasswordController.getErrorMessage);
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
