import 'package:flutter/material.dart';
import '../../../data/models/protocol.dart';
import '../../theme/app_colors.dart';

extension AppServerProtocolColor on AppServerProtocol {
  Color get badgeColor => switch (this) {
    AppServerProtocol.vmess => AppColors.protocolVMess,
    AppServerProtocol.vless => AppColors.protocolVLESS,
    AppServerProtocol.trojan => AppColors.protocolTrojan,
    AppServerProtocol.shadowsocks => AppColors.protocolShadowsocks,
    AppServerProtocol.hysteria2 => AppColors.protocolHy2,
    AppServerProtocol.wireguard => AppColors.protocolWG,
    AppServerProtocol.unknown => AppColors.contentPrimary,
  };
}