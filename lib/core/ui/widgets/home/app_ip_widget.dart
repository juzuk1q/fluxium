import 'package:Fluxium/core/ui/theme/app_text_styles.dart';
import 'package:vize/vize.dart';
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'app_icon_button.dart';

class IPWidget extends StatefulWidget {
  final String icon;

  const IPWidget({super.key, required this.icon});

  @override
  State<IPWidget> createState() => _IPWidgetState();
}

class _IPWidgetState extends State<IPWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 345.fw,
      height: 61.fh,
      decoration: BoxDecoration(
        color: AppColors.ghostButtonBackground,
        border: Border.all(color: AppColors.ghostButtonBorder),
        borderRadius: .circular(16.r),
      ),
      margin: po(l: 5, r: 5, b: 8),
      padding: po(r: 16, t: 10, b: 10, l: 14),
      child: Row(
        mainAxisAlignment: .start,
        crossAxisAlignment: .center,
        children: [
          Text('🇷🇺', style: TextStyle(fontFamily: 'Emoji', fontSize: 22),),
          SizedBox(width: 12.fw),
          Column(
            crossAxisAlignment: .start,
            children: [
              Row(
                crossAxisAlignment: .center,
                children: [
                  Text('Your IP', style: AppTextStyles.body12.copyWith(color: AppColors.contentSecondary),),
                  Text(' · Exposed'.toUpperCase(), style: AppTextStyles.body10.copyWith(color: AppColors.error, fontWeight: .w700),)
                ],
              ),
              Row(
                children: [
                Text('188.162.58.103', style: AppTextStyles.metricIP,),
                Text(' · Moscow, Russia', style: AppTextStyles.body10.copyWith(color: AppColors.contentSecondary),)
              ],)
            ],
          ),
          Spacer(),
          AppIconButton(icon: 'assets/icons/eye_show.svg'),
        ],
      ),
    );
  }
}
