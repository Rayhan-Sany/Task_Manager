import 'package:flutter/material.dart';
import 'package:task_manager/presentation/controllers/auth_controller.dart';
import 'package:task_manager/presentation/screens/main_bottom_nav_bar_screen.dart';
import 'package:task_manager/presentation/widgets/logoSvg.dart';
import 'package:task_manager/presentation/widgets/svg_background_setter.dart';
import 'auth/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    bool isLoggedIn =await AuthController.isUserLoggedIn();
    print('${isLoggedIn.toString()}------------------------\n\n');
    if (isLoggedIn) {
      if (mounted) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) => const MainBottomNavBarScreen()), (
            route) => false);
      }
    }
    else{
      if(mounted){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignIn()),
        );
      }
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
