import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/presentation/utils/assets_path.dart';

class SvgBackgroundSetter extends StatelessWidget {
  final Widget child;

  const SvgBackgroundSetter({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(AssetsPath.backgroundSvg,
            height: double.infinity, width: double.infinity, fit: BoxFit.cover),
         child,
      ],
    );
  }
}
