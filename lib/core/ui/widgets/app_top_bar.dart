import 'package:Fluxium/core/ui/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:vize/vize.dart';
import '../theme/app_colors.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String leftText;        // Версия "0.0.1a" или заголовок "Configs"
  final TextStyle? textStyle;
  final Widget? centerWidget;   // AppStatus
  final List<Widget>? actions;  // Иконки справа

  const AppTopBar({
    super.key,
    required this.leftText,
    this.textStyle,
    this.centerWidget,
    this.actions,
  });

  static const double contentHeight = 56;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        height: contentHeight,
        padding: po(l: 24, r: 24, t: 10),
        color: AppColors.surfaceBackground,
        child: Row(
          crossAxisAlignment: .center,
          children: [
            Expanded(
              child: Align(
                alignment: .centerLeft,
                child: Text(
                  leftText,
                  style: textStyle ?? AppTextStyles.header,
                  ),
                ),
              ),
            if (centerWidget != null)
              Expanded(
                flex: 2,
                child: Center(
                  child: centerWidget!,
                ),
              ),
            Expanded(
              child: Align(
                alignment: .centerRight,
                child: Transform.translate(
                  offset: Offset(0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: actions ?? [],
                  ),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(contentHeight);
}