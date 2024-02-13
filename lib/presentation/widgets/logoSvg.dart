import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/assets_path.dart';

class LogoSvg extends StatelessWidget {
  const LogoSvg({super.key});
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(AssetsPath.logoSvg,
        width: 120, fit: BoxFit.scaleDown);
  }
}
