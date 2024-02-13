import 'package:flutter/material.dart';
import 'package:task_manager/presentation/widgets/svg_background_setter.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SvgBackgroundSetter(
        child: Column(
          children: [

          ],
        ),
      ),

    );
  }
}
