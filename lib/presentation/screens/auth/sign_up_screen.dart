import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:task_manager/presentation/widgets/svg_background_setter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

final TextEditingController _emailNameTEcontroller = TextEditingController();
final TextEditingController _firstNameTEcontroller = TextEditingController();
final TextEditingController _lastNameTEcontroller = TextEditingController();
final TextEditingController _mobileTEcontroller = TextEditingController();
final TextEditingController _passwordTEcontroller = TextEditingController();
final GlobalKey<FormState> _formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SvgBackgroundSetter(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 40, right: 30,top:110),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Join With Us',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      enabled: true,
                      decoration: const InputDecoration(hintText: 'Email'),
                      controller:_emailNameTEcontroller,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      enabled: true,
                      decoration: const InputDecoration(hintText: 'First Name'),
                      controller: _firstNameTEcontroller,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      enabled: true,
                      decoration: const InputDecoration(hintText: 'Last Name'),
                      controller: _lastNameTEcontroller,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      enabled: true,
                      decoration: const InputDecoration(hintText: 'Mobile'),
                      controller:_mobileTEcontroller,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      enabled: true,
                      decoration: const InputDecoration(hintText: 'Password'),
                      controller: _passwordTEcontroller,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(onPressed: (){}, child:const Icon(Symbols.expand_circle_right),),
                    const SizedBox(height:20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text('Have account?',
                        style: Theme.of(context).textTheme.titleMedium),
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child:const Text('Sign In'),)
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
    _firstNameTEcontroller.dispose();
    _lastNameTEcontroller.dispose();
    _mobileTEcontroller.dispose();
    _passwordTEcontroller.dispose();
    super.dispose();
  }
}
