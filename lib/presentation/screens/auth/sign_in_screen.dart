import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:task_manager/data/models/login_response.dart';
import 'package:task_manager/data/models/response_object.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/presentation/controllers/auth_controller.dart';
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
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailTEcontroller = TextEditingController();
  final TextEditingController passwordTEcontroller = TextEditingController();
  bool _obsecure = true;
  bool _signInNotInProgress = true;

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
          key: _formkey,
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
                controller:emailTEcontroller,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                enabled: true,
                keyboardType:TextInputType.emailAddress,
                validator: emailValidator,
              ),
              const SizedBox(height: 12),
              TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          _obsecure ? _obsecure = false : _obsecure = true;
                          setState(() {});
                        },
                        icon: Icon(_obsecure
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined),
                      )),
                  controller: passwordTEcontroller,
                  obscureText: _obsecure,
                  validator: (value) {
                    return passwordValidator(value);
                  }),
              const SizedBox(height: 12),
              Visibility(
                visible: _signInNotInProgress,
                replacement: Center(
                    child: CircularProgressIndicator(
                      color: AppColor.baseColor,
                    )),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _signIn();
                    }
                  },
                  child: const Icon(Symbols.expand_circle_right),
                ),
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

  void _signIn() async {
    _signInNotInProgress = false;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": emailTEcontroller.text.trim(),
      "password": passwordTEcontroller.text,
    };
    ResponseObject response =
    await NetworkCaller.postRequest(Url.logInUrl, requestBody);
    if (response.isSuccess) {
      if (!mounted) return;
      LoginResponse loginResponse = LoginResponse.fromJson(response.body);
      AuthController.saveUserData(loginResponse.userData!);
      AuthController.saveUserToken(loginResponse.token!);
      if (mounted) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) => const MainBottomNavBarScreen()), (
            route) => false);
      }
    }
    else{
      if(mounted){
        commonSnackBar(context:context,snackBarContent:'Login Failed Try Again',isErrorSnack:true);
      }
    }
    _signInNotInProgress = true;
    setState(() {});
  }

  @override
  void dispose() {
    emailTEcontroller.dispose();
    passwordTEcontroller.dispose();
    super.dispose();
  }
} //State
