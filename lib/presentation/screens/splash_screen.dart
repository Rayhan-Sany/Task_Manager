import 'package:flutter/material.dart';
import 'package:task_manager/presentation/screens/sign_in_screen.dart';
import 'package:task_manager/presentation/widgets/logoSvg.dart';
import 'package:task_manager/presentation/widgets/svg_background_setter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToSignIn();
  }

  Future<void> _moveToSignIn() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignIn()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SvgBackgroundSetter(
        child: Center(
          child: LogoSvg(),
        ),
      ),
    );
  }
}
