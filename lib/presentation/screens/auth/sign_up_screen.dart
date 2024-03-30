
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:task_manager/presentation/controllers/sign_up_controller.dart';
import 'package:task_manager/presentation/utils/app_color.dart';
import 'package:task_manager/presentation/widgets/common_snackbar.dart';
import 'package:task_manager/presentation/widgets/svg_background_setter.dart';
import 'package:string_validator/string_validator.dart' as str;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailNameTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SvgBackgroundSetter(
          child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 40, right: 30, top: 110),
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Join With Us',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 15),
            TextFormField(
              enabled: true,
              decoration: const InputDecoration(hintText: 'Email'),
              controller: _emailNameTEController,
              keyboardType: TextInputType.emailAddress,
              validator: emailValidator,
            ),
            const SizedBox(height: 12),
            TextFormField(
              enabled: true,
              decoration: const InputDecoration(hintText: 'First Name'),
              controller: _firstNameTEController,
              validator: (value) {
                return isFieldEmptyValidityCheck(
                    value, 'Enter Your First Name');
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              enabled: true,
              decoration: const InputDecoration(hintText: 'Last Name'),
              controller: _lastNameTEController,
              validator: (value) {
                return isFieldEmptyValidityCheck(value, 'Enter Your Last Name');
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              enabled: true,
              decoration: const InputDecoration(hintText: 'Mobile'),
              controller: _mobileTEController,
              keyboardType: TextInputType.phone,
              validator: (value) {
                return isFieldEmptyValidityCheck(value, 'Enter Your Mobile');
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              enabled: true,
              decoration: const InputDecoration(hintText: 'Password'),
              controller: _passwordTEController,
              validator:passwordValidator,
            ),
            const SizedBox(height: 12),
            GetBuilder<SignUpController>(
              builder: (signUpController) {
                return Visibility(
                  visible:signUpController.isSignUpInProgress==false,
                  replacement: Center(
                      child: CircularProgressIndicator(
                    color: AppColor.baseColor,
                  )),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _signUp();
                      }
                    },
                    child: const Icon(Symbols.expand_circle_right),
                  ),
                );
              }
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Have account?',
                    style: Theme.of(context).textTheme.titleMedium),
                TextButton(
                  onPressed: () {
                   Get.back();
                  },
                  child: const Text('Sign In'),
                )
              ],
            ),
          ]),
        ),
      )),
    );
  }

  void _signUp() async {
    FocusScope.of(context).unfocus();
    Map<String, dynamic> requestBody = {
      "email": _emailNameTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
      "password": _passwordTEController.text,
    };
    final result =
        await Get.find<SignUpController>().signUp(requestBody);
    if (result) {
      if (mounted) {
        commonSnackBar(
            context: context, snackBarContent: 'Sign Up Success please log in');
        Get.back();
      }
    } else {
      if (mounted) {
        commonSnackBar(
            context: context,
            snackBarContent:Get.find<SignUpController>().getErrorMessage,
            isErrorSnack: true);
      }
    }
  }

  bool isFieldEmpty(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return true;
    } else {
      return false;
    }
  }

  String? isFieldEmptyValidityCheck(String? value, String validatorMassage) {
    if (value?.trim().isEmpty ?? true) {
      return validatorMassage;
    } else {
      return null;
    }
  }

  String? emailValidator(String? value) {
    if (isFieldEmpty(value)) {
      return 'Enter Your Email';
    }
    else if(!str.isEmail(value??'')){
      return 'Enter Valid Email';
    }
      else {
      return null;
    }
  }

  String? passwordValidator(String? value) {
    if (value == null || isFieldEmpty(value)) {
      return 'Enter Your Password';
    } else if (value.length < 6) {
      return 'Password length Should be At Least 6 character';
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    _emailNameTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
