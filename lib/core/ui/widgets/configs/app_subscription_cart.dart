import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import 'app_subBase.dart';

enum SubscriptionStatus { active, expired, expiringSoon }

class SubscriptionCard extends StatelessWidget {
  final String title;
  final int serverCount;
  final SubscriptionStatus? status;
  final DateTime lastUpdated;
  final double? usedGb;
  final double? limitGb;
  final String? description;
  final List<Widget> serverTiles;
  final VoidCallback? onRefresh;
  final VoidCallback? onSpeedTest;
  final VoidCallback? onMore;

  const SubscriptionCard({
    super.key,
    required this.title,
    required this.serverCount,
    this.status,
    required this.lastUpdated,
    this.usedGb,
    this.limitGb,
    this.description,
    required this.serverTiles,
    this.onRefresh,
    this.onSpeedTest,
    this.onMore,
  });

  Color get _statusColor => switch (status) {
    SubscriptionStatus.active => AppColors.success,
    SubscriptionStatus.expired => AppColors.error,
    SubscriptionStatus.expiringSoon => AppColors.warning,
    null => AppColors.contentSecondary,
  };

  String get _statusLabel => switch (status) {
    SubscriptionStatus.active => 'Active',
    SubscriptionStatus.expired => 'Expired',
    SubscriptionStatus.expiringSoon => 'Expiring soon',
    null => '',
  };

  @override
  Widget build(BuildContext context) {
    return ConfigCardBase(
      title: title,
      serverCount: serverCount,
      lastUpdated: lastUpdated,
      serverTiles: serverTiles,
      primaryActionIcon: Icons.refresh,
      onPrimaryAction: onRefresh,
      onSpeedTest: onSpeedTest,
      onMore: onMore,
      bodyBuilder: (context) {
        final isUnlimited = limitGb?.isInfinite ?? true;
        final progress = isUnlimited
            ? 0.0
            : ((usedGb ?? 0) / limitGb!).clamp(0.0, 1.0);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConfigCardMetaRow(
              leading: Text(
                _statusLabel,
                style: AppTextStyles.body9.copyWith(color: _statusColor),
              ),
              lastUpdated: lastUpdated,
              serverCount: serverCount,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '${(usedGb ?? 0).toStringAsFixed(0)} GB',
                  style: AppTextStyles.body9.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: isUnlimited ? 0 : progress,
                      minHeight: 6,
                      backgroundColor: AppColors.border,
                      valueColor: AlwaysStoppedAnimation(_statusColor),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  isUnlimited ? '∞' : '${(limitGb ?? 0).toStringAsFixed(1)} TB',
                  style: AppTextStyles.body9.copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            if (description != null && description!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(description!, style: AppTextStyles.body12),
            ],
          ],
        );
      },
    );
  }
}