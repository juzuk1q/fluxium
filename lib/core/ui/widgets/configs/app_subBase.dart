import 'package:flutter/material.dart';
import 'package:vize/vize.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '/core/utils/date_format.dart';

class ConfigCardBase extends StatefulWidget {
  final String title;
  final int serverCount;
  final DateTime lastUpdated;
  final List<Widget> serverTiles;

  final WidgetBuilder bodyBuilder;

  final IconData primaryActionIcon; // refresh для подписки, edit для ручных
  final VoidCallback? onPrimaryAction;
  final VoidCallback? onSpeedTest;
  final VoidCallback? onMore;

  const ConfigCardBase({
    super.key,
    required this.title,
    required this.serverCount,
    required this.lastUpdated,
    required this.serverTiles,
    required this.bodyBuilder,
    required this.primaryActionIcon,
    this.onPrimaryAction,
    this.onSpeedTest,
    this.onMore,
  });

  @override
  State<ConfigCardBase> createState() => _ConfigCardBaseState();
}

class _ConfigCardBaseState extends State<ConfigCardBase> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: po(b: 2, l: 20, r: 20, t: 8),
      padding: po(l: 8, t: 6, b: 4, r: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: .circular(14),
        border: .all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _expanded = !_expanded),
                  child: Row(
                    children: [
                      AnimatedRotation(
                        turns: _expanded ? 0.25 : 0,
                        duration: Duration(milliseconds: 200),
                        child: Icon(
                          Icons.chevron_right,
                          color: AppColors.contentDisabled,
                        ),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          widget.title,
                          style: AppTextStyles.body15.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _headerIconButton(
                widget.primaryActionIcon,
                widget.onPrimaryAction,
              ),
              SizedBox(width: 6),
              _headerIconButton(Icons.bolt, widget.onSpeedTest),
              SizedBox(width: 6),
              _headerIconButton(Icons.more_horiz, widget.onMore),
              SizedBox(width: 6),
            ],
          ),
          AnimatedSize(
            duration: Duration(milliseconds: 200),
            child: _expanded
                ? Column(
                    children: [
                      SizedBox(height: 12),
                      widget.bodyBuilder(context),
                      SizedBox(height: 12),
                      ...widget.serverTiles,
                    ],
                  )
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _headerIconButton(IconData icon, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 22,
        height: 27,
        decoration: BoxDecoration(
          color: AppColors.ghostButtonBackground,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }
}

class ConfigCardMetaRow extends StatelessWidget {
  final Widget leading; // слева: статус ИЛИ счётчик трафика
  final DateTime lastUpdated;
  final int serverCount;

  const ConfigCardMetaRow({
    super.key,
    required this.leading,
    required this.lastUpdated,
    required this.serverCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        leading,
        Row(
          children: [
            Text(formatDate(lastUpdated), style: AppTextStyles.body9),
            SizedBox(width: 6),
            Text('· $serverCount', style: AppTextStyles.body9),
            SizedBox(width: 2),
            Icon(
              Icons.dns_outlined,
              size: 14,
              color: AppColors.contentDisabled,
            ),
          ],
        ),
      ],
    );
  }
}
