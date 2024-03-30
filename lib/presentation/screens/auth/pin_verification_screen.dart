import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/presentation/controllers/pin_verification_controller.dart';
import 'package:task_manager/presentation/screens/auth/set_password_screen.dart';
import 'package:task_manager/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_manager/presentation/widgets/common_snackbar.dart';
import 'package:task_manager/presentation/widgets/svg_background_setter.dart';

class PinVerificationScreen extends StatefulWidget {
  final String email;

  const PinVerificationScreen({super.key, required this.email});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  PinVerificationController pinVerificationController =
      Get.find<PinVerificationController>();
  final TextEditingController _pinTEController = TextEditingController();
  bool isPinFieldNotNull = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SvgBackgroundSetter(
          child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 40, right: 30, top: 200),
        child: pinVerificationForm(context),
      )),
    );
  }

  Form pinVerificationForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Pin Verification',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          'A 6 digit verification pin will send to your email address',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 15),
        GetBuilder<PinVerificationController>(
            builder: (pinVerificationController) {
          return otpVerificationField(context);
        }),
        const SizedBox(height: 12),
        GetBuilder<PinVerificationController>(
            builder: (pinVerificationController) {
          return Visibility(
            visible:
                pinVerificationController.isPinVerificationInProgress == false,
            replacement: const Center(child: CircularProgressIndicator()),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _verifyOTP();
                }
              },
              child: const Icon(Symbols.expand_circle_right),
            ),
          );
        }),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Have account?',
                style: Theme.of(context).textTheme.titleMedium),
            TextButton(
              onPressed: () {
                Get.offAll(const SignIn());
              },
              child: const Text('Sign In'),
            ),
          ],
        ),
      ]),
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
      controller: _pinTEController,
      onCompleted: (v) {
        print("Completed");
      },
      validator: (String? value) {
        if (value?.isEmpty ?? true) {
          return 'Enter 6 Digit Pin';
        } else if (value != null && value.isNotEmpty && value.length < 6) {
          return 'Please Fill All The Pin Field';
        } else {
          return null;
        }
      },
      onChanged: (value) {
        print(value);
        pinVerificationController.needUpdate();
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

  Future<void> _verifyOTP() async {
    final result = await pinVerificationController.verifyOtp(
        widget.email, _pinTEController.text);
    if (result) {
      if (mounted) {
        Get.to(
            SetPasswordScreen(otp: _pinTEController.text, email: widget.email));
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => SetPasswordScreen(
        //             otp: _pinTEController.text, email: widget.email)));
      }
    } else {
      if (mounted) {
        commonSnackBar(
            context: context,
            snackBarContent: pinVerificationController.getErrorMessage,
            isErrorSnack: true);
      }
    }
  }

  @override
  void dispose() {
    _pinTEController.dispose();
    super.dispose();
  }
}
