import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:task_manager/presentation/screens/auth/pin_verification_screen.dart';
import 'package:task_manager/presentation/widgets/svg_background_setter.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {

  final TextEditingController _emailNameTEcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SvgBackgroundSetter(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 40, right: 30, top: 200),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Email Address',
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleLarge,
                    ),
                    Text(
                      'A 6 digit verification pin will send to your email address',
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleSmall,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      enabled: true,
                      decoration: const InputDecoration(hintText: 'Email'),
                      controller: _emailNameTEcontroller,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const PinVerificationScreen()));
                    },
                      child: const Icon(Symbols.expand_circle_right),),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Have account?',
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleMedium),
                        TextButton(onPressed: () {
                          Navigator.pop(context);
                        }, child: const Text('Sign In'),)
                      ],
                    ),
                  ]),
            ),
          )),
    );
  }

  @override
  void dispose() {
    _emailNameTEcontroller.dispose();
    super.dispose();
  }
}
