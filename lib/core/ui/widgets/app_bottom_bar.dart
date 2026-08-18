import 'package:Fluxium/core/ui/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_colors.dart';

class AppBottomBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const AppBottomBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  static const _items = [
    (
      outline: 'assets/icons/home_outline.svg',
      filled: 'assets/icons/home_filled.svg',
      label: 'Home',
    ),
    (
      outline: 'assets/icons/configs_outline.svg',
      filled: 'assets/icons/configs_filled.svg',
      label: 'Configs',
    ),
    (
      outline: 'assets/icons/settings_outline.svg',
      filled: 'assets/icons/settings_filled.svg',
      label: 'Settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: .fromLTRB(50, 0, 50, 22),
        child: Container(
          padding: .all(4),
          decoration: BoxDecoration(
            color: AppColors.surfaceCard,
            borderRadius: BorderRadius.circular(360),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: Color(0xff000000).withValues(alpha: .7),
                offset: Offset(145, 35),
                blurRadius: 50,
              ),
              BoxShadow(
                color: Color(0xff000000).withValues(alpha: .7),
                offset: Offset(-145, 35),
                blurRadius: 50,
              ),
            ],
          ),
          child: Row(
            children: List.generate(_items.length, (i) {
              final selected = i == selectedIndex;
              final item = _items[i];
              return Expanded(
                child: GestureDetector(
                  onTap: () => onTabSelected(i),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    padding: .symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.ghostButtonBackground.withValues(alpha: .2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(360),
                    ),
                    child: Column(
                      mainAxisSize: .min,
                      children: [
                        SvgPicture.asset(
                          selected ? item.filled : item.outline,
                          color: selected
                              ? AppColors.contentPrimary
                              : AppColors.contentSecondary,
                          height: 22,
                        ),
                        SizedBox(height: 2),
                        Text(
                          item.label,
                          style: AppTextStyles.body11.copyWith(
                            color: selected
                                ? AppColors.contentPrimary
                                : AppColors.contentSecondary
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
