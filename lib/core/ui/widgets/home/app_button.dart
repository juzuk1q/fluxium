import 'package:Fluxium/core/ui/theme/app_colors.dart';
import 'package:Fluxium/core/ui/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vize/vize.dart';

class AppButton extends StatefulWidget {
  final String icon;
  final String label;

  const AppButton({super.key, required this.icon, required this.label});

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.fh,
      width: 168.fw,
      margin: po(l: 4, r: 4, b: 8),
      decoration: BoxDecoration(
        color: AppColors.ghostButtonBackground,
        border: .all(color: AppColors.ghostButtonBorder),
        borderRadius: .circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: .center,
        mainAxisAlignment: .center,
        children: [
          SvgPicture.asset(widget.icon, height: 16, width: 16, color: AppColors.contentDisabled,),
          SizedBox(width: 6.fw,),
          Text(widget.label, style: AppTextStyles.body15.copyWith(color: AppColors.contentDisabled),)
        ],
      ),
    );
  }
}
