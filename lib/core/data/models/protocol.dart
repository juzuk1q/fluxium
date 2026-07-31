// lib/core/data/models/server_protocol.dart
enum AppServerProtocol {
  vmess,
  vless,
  trojan,
  shadowsocks,
  hysteria2,
  wireguard,
  unknown;

  static AppServerProtocol fromString(String raw) {
    return switch (raw.toLowerCase()) {
      'vmess' => AppServerProtocol.vmess,
      'vless' => AppServerProtocol.vless,
      'trojan' => AppServerProtocol.trojan,
      'shadowsocks' || 'ss' => AppServerProtocol.shadowsocks,
      'hysteria2' || 'hy2' => AppServerProtocol.hysteria2,
      'wireguard' || 'wg' => AppServerProtocol.wireguard,
      _ => AppServerProtocol.unknown,
    };
  }

  /// Лейбл для бейджа — то, что видит юзер.
  String get label => switch (this) {
    AppServerProtocol.vmess => 'VMess',
    AppServerProtocol.vless => 'VLESS',
    AppServerProtocol.trojan => 'Trojan',
    AppServerProtocol.shadowsocks => 'Shadowsocks',
    AppServerProtocol.hysteria2 => 'Hysteria2',
    AppServerProtocol.wireguard => 'WireGuard',
    AppServerProtocol.unknown => 'wtf',
  };
}