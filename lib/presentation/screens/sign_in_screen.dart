import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:task_manager/presentation/screens/email_verification_screen.dart';
import 'package:task_manager/presentation/screens/sign_up_screen.dart';
import 'package:task_manager/presentation/widgets/svg_background_setter.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailTEcontroller = TextEditingController();
  final TextEditingController passwordTEcontroller = TextEditingController();

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
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 20),
              signInTextFormField(
                  lebelText: 'Email',
                  teController: emailTEcontroller,
                  validator: (value) {
                    return emailValidator(value);
                  }),
              const SizedBox(height: 12),
              signInTextFormField(
                  lebelText: 'Password',
                  teController: passwordTEcontroller,
                  validator: (value) {
                    return passwordValidator(value);
                  },
                  obscure: true),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    print("Button Clicked");
                  }
                },
                child: const Icon(Symbols.expand_circle_right),
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
                        style: Theme.of(context).textTheme.titleMedium,
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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>const EmailVerificationScreen()),);
      },
      child: Text(
        'Forget Password?',
        style: TextStyle(
          color: Colors.black.withOpacity(0.5),
        ),
      ),
    );
  }

  Widget signInTextFormField(
      {required String lebelText,
      required TextEditingController teController,
      required FormFieldValidator<String> validator,
      bool obscure = false}) {
    return TextFormField(
      decoration: InputDecoration(
        label: Text(lebelText),
      ),
      enabled: true,
      obscureText: obscure,
      validator: validator,
    );
  }

  String? emailValidator(String? value) {
    if (value!.trim().isNotEmpty) return null;
    return "Enter Valid Email";
  }

  String? passwordValidator(String? value) {
    if (value!.trim().isNotEmpty) return null;
    return "Enter Valid Password";
  }

  @override
  void dispose() {
    emailTEcontroller.dispose();
    passwordTEcontroller.dispose();
    super.dispose();
  }
} //State
