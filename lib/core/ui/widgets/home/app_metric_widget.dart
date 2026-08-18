import 'package:Fluxium/core/ui/theme/app_text_styles.dart';
import 'package:vize/vize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_colors.dart';

class MetricWidget extends StatefulWidget {
  final String icon;
  final String text;
  final String metricValue;
  final String metricUnit;
  final Color color;

  const MetricWidget({
    super.key,
    required this.icon,
    required this.text,
    required this.metricValue,
    required this.metricUnit,
    required this.color,
  });

  @override
  State<MetricWidget> createState() => _MetricWidgetState();
}

class _MetricWidgetState extends State<MetricWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 168.fw,
      height: 97.fh,
      decoration: BoxDecoration(
        color: AppColors.ghostButtonBackground,
        border: Border.all(color: AppColors.ghostButtonBorder),
        borderRadius: .circular(16.r),
      ),
      margin: po(l: 4, r: 4, b: 8),
      padding: ps(h: 16, v: 14),
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Spacer(),
          Row(
            children: [
              SvgPicture.asset(
                widget.icon,
                colorFilter: .mode(widget.color, .srcIn),
                height: 18,
              ),
              SizedBox(width: 5.fw),
              Text(
                widget.text.toUpperCase(),
                style: AppTextStyles.body12.copyWith(
                  fontWeight: .w700,
                  color: widget.color,
                ),
              ),
            ],
          ),
          Spacer(),
          Row(
            textBaseline: .alphabetic,
            crossAxisAlignment: .baseline,
            children: [
              Text(
                widget.metricValue,
                style: AppTextStyles.metricValue.copyWith(color: widget.color),
              ),
              SizedBox(width: 2.fw,),
              Text(
                widget.metricUnit.toUpperCase(),
                style: AppTextStyles.metricUnit.copyWith(color: widget.color),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
