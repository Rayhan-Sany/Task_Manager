import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:task_manager/presentation/controllers/sign_in_controller.dart';
import 'package:task_manager/presentation/screens/auth/email_verification_screen.dart';
import 'package:task_manager/presentation/screens/main_bottom_nav_bar_screen.dart';
import 'package:task_manager/presentation/screens/auth/sign_up_screen.dart';
import 'package:task_manager/presentation/widgets/common_snackbar.dart';
import 'package:task_manager/presentation/widgets/svg_background_setter.dart';
import '../../utils/app_color.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final SignInController _signInController = Get.find<SignInController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SvgBackgroundSetter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(left: 40, right: 30),
              child: signInSizedBox(context),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox signInSizedBox(BuildContext context) {
    return SizedBox(
      child: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Get Started With',
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge),
              const SizedBox(height: 20),
              TextFormField(
                controller:_emailTEController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                enabled: true,
                keyboardType:TextInputType.emailAddress,
                validator: emailValidator,
              ),
              const SizedBox(height: 12),
              GetBuilder<SignInController>(
                builder: (signInController) {
                  return TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              signInController.changeObscure(signInController.getObscure);
                            },
                            icon: Icon(signInController.getObscure
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                          )),
                      controller: _passwordTEController,
                      obscureText: signInController.getObscure,

                      validator: (value) {
                        return passwordValidator(value);
                      });
                }
              ),
              const SizedBox(height: 12),
              GetBuilder<SignInController>(
                builder: (controller) {
                  return Visibility(
                    visible: _signInController.isSignInInProgress==false,
                    replacement: Center(
                        child: CircularProgressIndicator(
                          color: AppColor.baseColor,
                        )),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _signIn();
                        }
                      },
                      child: const Icon(Symbols.expand_circle_right),
                    ),
                  );
                }
              ),
              const SizedBox(height: 40),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  forgotPasswordButton(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have account?',
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium,
                      ),
                      signUpTextButton(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextButton signUpTextButton() {
    return TextButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SignUpScreen()));
      },
      style: TextButton.styleFrom(alignment: Alignment.topLeft),
      child: const Text('Sign up'),
    );
  }

  TextButton forgotPasswordButton() {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const EmailVerificationScreen()),
        );
      },
      child: Text(
        'Forget Password?',
        style: TextStyle(
          color: Colors.black.withOpacity(0.5),
        ),
      ),
    );
  }

  String? emailValidator(String? value) {
    if (value!.trim().isNotEmpty) return null;
    return "Enter Valid Email";
  }

  String? passwordValidator(String? value) {
    if (value == null || value
        .trim()
        .isEmpty) {
      return 'Enter Your Password';
    } else if (value.length < 6) {
      return 'Password length Should be At Least 6 character';
    } else {
      return null;
    }
  }

  Future<void> _signIn() async {
    FocusScope.of(context).unfocus();
    bool result =
    await _signInController.signIn(
        _emailTEController.text.trim(), _passwordTEController.text);
    if (result) {
      if (mounted) {
       Get.offAll(const MainBottomNavBarScreen());
      }
    }
    else{
      if(mounted){
        commonSnackBar(
            context: context,
            snackBarContent: _signInController.getErrorMessage,
            isErrorSnack: true);
      }
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
} //State
