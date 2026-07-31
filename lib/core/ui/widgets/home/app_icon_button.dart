import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_colors.dart';
import 'package:vize/vize.dart';

class AppIconButton extends StatefulWidget {
  final String icon;
  final double? height;

  const AppIconButton({super.key, required this.icon, this.height = 22});

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.fh,
      width: 32.fw,
      decoration: BoxDecoration(
        color: AppColors.ghostButtonBackground,
        border: .all(color: AppColors.ghostButtonBorder),
        borderRadius: .circular(8.r),
      ),
      margin: po(l: 6),
      padding: pa(5),
      child: SvgPicture.asset(widget.icon, color: AppColors.contentPrimary, height: widget.height),
    );
  }
}
