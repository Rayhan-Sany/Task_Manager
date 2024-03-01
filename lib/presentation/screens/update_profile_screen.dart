import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:task_manager/presentation/widgets/profile_appbar.dart';
import 'package:task_manager/presentation/widgets/svg_background_setter.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});
  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailNameTEcontroller = TextEditingController();
  final TextEditingController _firstNameTEcontroller = TextEditingController();
  final TextEditingController _lastNameTEcontroller = TextEditingController();
  final TextEditingController _mobileTEcontroller = TextEditingController();
  final TextEditingController _passwordTEcontroller = TextEditingController();
  final TextEditingController _photoTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int count =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppDefaultAppBar.appBar(isNotInProfileScreen:false),
      body: SvgBackgroundSetter(
          child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 40, right: 30, top: 45),
        child: updateProfileForm(context),
      )),
    );
  }

  Form updateProfileForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Update Profile',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Flexible(
              child: TextFormField(
                enabled: false,
                decoration: const InputDecoration(
                    hintText: 'Photos',
                    hintStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.normal),
                    filled: true,
                    fillColor: Colors.black54),
              ),
            ),
            Flexible(
              flex: 2,
              child: TextFormField(
                controller: _photoTEController,
                enabled: true,
                decoration: const InputDecoration(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        TextFormField(
          enabled: true,
          decoration: const InputDecoration(hintText: 'Email'),
          controller: _emailNameTEcontroller,
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
          controller: _mobileTEcontroller,
        ),
        const SizedBox(height: 12),
        TextFormField(
          enabled: true,
          decoration: const InputDecoration(hintText: 'Password'),
          controller: _passwordTEcontroller,
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
                Navigator.pop(context);
              },
              child: const Text('Sign In'),
            )
          ],
        ),
      ]),
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
