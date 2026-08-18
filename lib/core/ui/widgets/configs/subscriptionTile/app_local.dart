import 'package:flutter/material.dart';
import '../../../theme/app_text_styles.dart';
import 'app_sub_base.dart';

class LocalConfigCard extends StatelessWidget {
  final String title;
  final int serverCount;
  final DateTime lastUpdated;
  final double? usedGb;
  final List<Widget> serverTiles;
  final VoidCallback? onEdit;
  final VoidCallback? onSpeedTest;
  final VoidCallback? onMore;

  const LocalConfigCard({
    super.key,
    required this.title,
    required this.serverCount,
    required this.lastUpdated,
    this.usedGb,

    required this.serverTiles,
    this.onEdit,
    this.onSpeedTest,
    this.onMore,
  });

  @override
  Widget build(BuildContext context) {

    return ConfigCardBase(
      title: title,
      serverCount: serverCount,
      lastUpdated: lastUpdated,
      serverTiles: serverTiles,
      primaryActionIcon: Icons.edit_outlined,
      onPrimaryAction: onEdit,
      onSpeedTest: onSpeedTest,
      onMore: onMore,
      bodyBuilder: (context) {
        return ConfigCardMetaRow(
          leading: Text(
            '${(usedGb ?? 0).toStringAsFixed(0)} GB / ∞ GB',
            style: AppTextStyles.body9.copyWith(fontWeight: FontWeight.w700),
          ),
          lastUpdated: lastUpdated,
          serverCount: serverCount,
        );
      },
    );
  }
}