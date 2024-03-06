import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:task_manager/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_manager/presentation/widgets/svg_background_setter.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _passwordTEcontroller = TextEditingController();
  final TextEditingController _confirmPasswordTEcontroller =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obsecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SvgBackgroundSetter(
          child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 40, right: 30, top: 200),
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Set Password',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'Minimum length password 8 character with latter and number combination',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 15),
            TextFormField(
              obscureText: _obsecure,
              enabled: true,
              decoration: InputDecoration(
                hintText: 'Password',
                suffixIcon: IconButton(
                    onPressed: () {
                      _obsecure =  _obsecure?_obsecure=false:_obsecure=true;
                      setState(() {});
                    },
                    icon: Icon(_obsecure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined)),
              ),
              controller: _passwordTEcontroller,
            ),
            TextFormField(
              enabled: true,
              obscureText: _obsecure,
              decoration: InputDecoration(hintText: 'Confirm Password',suffixIcon: IconButton(
                  onPressed: () {
                    _obsecure?_obsecure=false:_obsecure=true;
                    setState(() {});
                  },
                  icon: Icon(_obsecure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined)),),
              controller: _confirmPasswordTEcontroller,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {},
              child: const Icon(Symbols.expand_circle_right),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Have account?',
                    style: Theme.of(context).textTheme.titleMedium),
                TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const SignIn()),
                        (route) => false);
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

  @override
  void dispose() {
    _passwordTEcontroller.dispose();
    _confirmPasswordTEcontroller.dispose();
    super.dispose();
  }
}