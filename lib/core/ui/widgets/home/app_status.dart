import 'package:Fluxium/core/ui/theme/app_colors.dart';
import 'package:Fluxium/core/ui/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:vize/vize.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Fluxium/core/ui/widgets/home/states/app_status_state.dart';

class AppStatus extends StatefulWidget {
  final StatusState state;
  const AppStatus({super.key, required this.state});

  factory AppStatus.isConnected() => AppStatus(state: StatusState.isConnected);
  factory AppStatus.notConnected() => AppStatus(state: StatusState.notConnected);

  @override
  State<AppStatus> createState() => _AppStatusState();
}

class _AppStatusState extends State<AppStatus> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.fh,
      decoration: BoxDecoration(
        color: AppColors.ghostButtonBackground,
        border: .all(color: AppColors.ghostButtonBorder),
        borderRadius: .circular(20.r),
      ),
      padding: po(l: 6, r: 12, t: 6, b: 6),
      child: Row(
        mainAxisSize: .min,
        children: [
          SvgPicture.asset(widget.state.icon, colorFilter: .mode(widget.state.color, .srcIn)),
          Text(widget.state.status, style: AppTextStyles.body14.copyWith(color: widget.state.color))
        ]
      ),
    );
  }
}
