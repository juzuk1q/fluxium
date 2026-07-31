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

  static const double contentHeight = 64;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        height: contentHeight,
        margin: po(b: 12),
        padding: ps(h: 24),
        color: AppColors.surfaceBackground,
        child: Row(
          crossAxisAlignment: .center,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment(-0.75, 8),
                child: Text(
                  leftText,
                  style: textStyle ?? AppTextStyles.header.copyWith(height: 1.7),
                  ),
                ),
              ),
            if (centerWidget != null)
              Expanded(
                flex: 2,
                child: Center(
                  child: Align(
                    alignment: Alignment(0, 2),
                      child: centerWidget!
                  ),
                ),
              ),
            Expanded(
              child: Align(
                alignment: Alignment(1, 0.5),
                child: Transform.translate(
                  offset: Offset(0, 4),
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