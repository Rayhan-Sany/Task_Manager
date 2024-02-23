import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/presentation/screens/set_password_screen.dart';
import 'package:task_manager/presentation/screens/sign_in_screen.dart';
import 'package:task_manager/presentation/widgets/svg_background_setter.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _pinTEcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              'Pin Verification',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'A 6 digit verification pin will send to your email address',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 15),
            otpVerificationField(context),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder:(context)=>const SetPasswordScreen()));
              },
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
                ),
              ],
            ),
          ]),
        ),
      )),
    );
  }

  PinCodeTextField otpVerificationField(BuildContext context) {
    return PinCodeTextField(
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        inactiveColor: Colors.black,
        inactiveFillColor: Colors.white,
        selectedFillColor: Colors.white,
        activeFillColor: Colors.white,
        selectedColor: Colors.blue,
      ),
      backgroundColor: Colors.transparent,
      keyboardType: TextInputType.number,
      enableActiveFill: true,
      controller: _pinTEcontroller,
      onCompleted: (v) {
        print("Completed");
      },
      onChanged: (value) {
        print(value);
        setState(() {
          // currentText = value;
        });
      },
      beforeTextPaste: (text) {
        print("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
      appContext: context,
    );
  }

  @override
  void dispose() {
    _pinTEcontroller.dispose();
    super.dispose();
  }
}
