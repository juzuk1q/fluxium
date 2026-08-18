// lib/core/ui/widgets/configs/server_tile.dart
import 'package:Fluxium/core/data/models/protocol.dart';
import 'package:Fluxium/core/ui/widgets/configs/app_protocols.dart';
import 'package:flutter/material.dart';
import 'package:vize/vize.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class ServerTile extends StatelessWidget {
  final String countryFlagEmoji; // напр. '🇯🇵'
  final String name; // 'Tokyo, Japan'
  final AppServerProtocol protocol; // 'VMess', 'VLESS', 'Hysteria2'...
  final int? pingMs; // null => N/A (ещё не измерен)
  final bool isSelected;
  final VoidCallback? onTap;

  const ServerTile({
    super.key,
    required this.countryFlagEmoji,
    required this.name,
    required this.protocol,
    this.pingMs,
    this.isSelected = false,
    this.onTap,
  });

  /// < 100ms → зелёный, 100-250ms → жёлтый, > 250ms → красный, N/A → серый
  Color get _pingColor {
    if (pingMs == null) return AppColors.contentDisabled;
    if (pingMs! < 100) return AppColors.success;
    if (pingMs! <= 250) return AppColors.warning;
    return AppColors.error;
  }

  String get _pingLabel => pingMs != null ? '$pingMs ms' : 'n/a';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        margin: po(b: 8),
        padding: po(l: 8, r: 12, t: 8, b: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.selectedButtonBackground : AppColors.ghostButtonBackground,
          border: .all(color: isSelected ? AppColors.selectedButtonBorder : AppColors.ghostButtonBorder),
          borderRadius: .circular(16.r),
        ),
        child: Row(
          children: [
            _FlagBadge(emoji: countryFlagEmoji),
            SizedBox(width: 10.fw),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.body14.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.fh),
                  _ProtocolBadge(protocol: protocol),
                ],
              ),
            ),
            SizedBox(width: 8.fw),
            Text(
              _pingLabel,
              style: AppTextStyles.body11.copyWith(
                color: _pingColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FlagBadge extends StatelessWidget {
  final String emoji;
  const _FlagBadge({required this.emoji});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      alignment: .center,
      decoration: BoxDecoration(
        color: AppColors.contentPrimary.withValues(alpha: .1),
        borderRadius: .circular(8.r),
      ),
      child: Image.asset('assets/emoji/$emoji', width: 28, height: 28),
    );
  }
}

class _ProtocolBadge extends StatelessWidget {
  final AppServerProtocol protocol;
  const _ProtocolBadge({required this.protocol});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: po(l: 8, r: 8, t: 1, b: 1),
      decoration: BoxDecoration(
        color: protocol.badgeColor.withValues(alpha: .15),
        borderRadius: .circular(4.r),
      ),
      child: Text(
        protocol.label,
        style: AppTextStyles.body10.copyWith(
          color: protocol.badgeColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}