import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/presentation/screens/auth/pin_verification_screen.dart';
import 'package:task_manager/presentation/widgets/common_snackbar.dart';
import 'package:task_manager/presentation/widgets/svg_background_setter.dart';
import 'package:string_validator/string_validator.dart' as str;
class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailNameTEController = TextEditingController();
  bool _emailVerificationInProgress = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SvgBackgroundSetter(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 40, right: 30, top: 200),
            child: emailVerificationForm(context),
          )),
    );
  }

  Form emailVerificationForm(BuildContext context) {
    return Form(
            key: _formKey,
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                controller: _emailNameTEController,
                validator:(String? value){
                  if(value==null) return 'Enter Your Email';
                  if(str.isEmail(value)) {
                return null;
              }else{
                    return 'Invalid Email';
                  }
            },
              ),
              const SizedBox(height: 12),
              Visibility(
                visible: _emailVerificationInProgress == false,
                replacement: const Center(child: CircularProgressIndicator()),
                child: ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
                      verifyEmailAndSentOtp();
                    }
                  },
                  child: const Icon(Symbols.expand_circle_right),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Have account?',
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleMedium),
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

  Future<void> verifyEmailAndSentOtp() async {
    _emailVerificationInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(
        Url.verifyEmailAndSentOtpUrl(_emailNameTEController.text));
    if (response.isSuccess) {
      if (response.body['status'] == 'fail') {
        if (mounted) {
          _emailVerificationInProgress = false;
          setState(() {});
          commonSnackBar(
              context: context,
              snackBarContent: response.body['data'],
              isErrorSnack: true);
        }
      } else if (response.body['status'] == 'success') {
        if (mounted) {
          _emailVerificationInProgress = false;
          setState(() {});
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PinVerificationScreen(
                        email: _emailNameTEController.text.trim(),)));
        }
      } else {
        if (mounted) {
          _emailVerificationInProgress = false;
          setState(() {});
          commonSnackBar(
              context: context,
              snackBarContent: response.body['data'],
              isErrorSnack: true);
        }
      }
    } else {
      if (mounted) {
        _emailVerificationInProgress = false;
        setState(() {});
        commonSnackBar(
            context: context,
            snackBarContent: response.errorMassage ?? 'Something Wrong',
            isErrorSnack: true);
      }
    }
  }

  @override
  void dispose() {
    _emailNameTEController.dispose();
    super.dispose();
  }
}
