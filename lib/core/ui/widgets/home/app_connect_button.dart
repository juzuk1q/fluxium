import 'package:Fluxium/core/ui/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vize/vize.dart';

class ConnectButton extends StatefulWidget {
  const ConnectButton({super.key});

  @override
  State<ConnectButton> createState() => _ConnectButtonState();
}

class _ConnectButtonState extends State<ConnectButton> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        // Halo-свечение
        Container(
          width: 400.fw,
          height: 298.fh ,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Color(0x40252525),
                Color(0x36252525),
                Color(0x2A252525),
                Color(0x02252525),
              ],
              stops: [0.2, 0.65, 0.8, 1.0],
            ),
          ),
        ),
        Container(
          width: 180.fw,
          height: 180.fh,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1E1E1E), Color(0xFF2E2E2E)],
            ),
            boxShadow: [BoxShadow(
              color: Color(0xff767676).withOpacity(0.2),
              offset: Offset(0, -5),
              blurRadius: 10,
            )],
            shape: BoxShape.circle,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/shield.svg', height: 56),
              Text('Connect', style: AppTextStyles.body15),
            ],
          ),
        ),
      ],
    );
  }
}
