import 'package:Fluxium/core/data/models/protocol.dart';
import 'package:Fluxium/core/ui/theme/app_text_styles.dart';
import 'package:Fluxium/core/ui/widgets/configs/modalSheets/app_add_button.dart';
import 'package:Fluxium/core/ui/widgets/configs/modalSheets/app_filter_button.dart';
import 'package:Fluxium/core/ui/widgets/configs/subscriptionTile/app_local.dart';
import 'package:Fluxium/core/ui/widgets/configs/serverTile/app_server_card.dart';
import 'package:Fluxium/core/ui/widgets/configs/subscriptionTile/app_subscription_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vize/vize.dart';
import 'dart:io';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:file_picker/file_picker.dart';
import 'package:Fluxium/core/ui/theme/app_colors.dart';
import 'package:Fluxium/core/ui/widgets/app_top_bar.dart';
import 'package:Fluxium/core/ui/widgets/home/app_icon_button.dart';

class ConfigsScreen extends StatefulWidget {
  const ConfigsScreen({super.key});

  @override
  State<ConfigsScreen> createState() => _ConfigsScreenState();
}

class _ConfigsScreenState extends State<ConfigsScreen> {

  void _handleConfigString(String value) {
    // TODO: логика добавления конфига (парсинг URL/JSON, сохранение и т.п.)
    print('Config received: $value');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.surfaceBackground,
      appBar: AppTopBar(
        leftText: 'Configs',
        actions: [
          AppIconButton(icon: 'assets/icons/latency.svg'),
          AppIconButton(icon: 'assets/icons/refresh.svg'),
          AppAddConfigsButton(
            onConfigString: _handleConfigString,
            onScanQr: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (_) => MobileScanner(
                  onDetect: (capture) {
                    final code = capture.barcodes.first.rawValue;
                    if (code != null) _handleConfigString(code);
                    Navigator.pop(context);
                  },
                ),
              ));
            },
            onPickFile: () async {
              final result = await FilePicker.platform.pickFiles();
              if (result != null) {
                final content = await File(result.files.single.path!).readAsString();
                _handleConfigString(content);
              }
            },
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: pa(6.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: po(b: 0, l: 20, r: 20, t: 8),
                  child: Row(
                    crossAxisAlignment: .center,
                    children: [
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            color: AppColors.ghostButtonBackground,
                            border: .all(color: AppColors.ghostButtonBorder),
                            borderRadius: .circular(12.r),
                          ),
                          child: TextField(
                            textAlignVertical: .center,
                            style: AppTextStyles.body14.copyWith(
                              color: AppColors.contentPrimary,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Transform.scale(
                                scale: .65,
                                child: SvgPicture.asset(
                                  'assets/icons/search.svg',
                                  colorFilter: .mode(
                                    AppColors.contentSelected,
                                    BlendMode.srcIn,
                                  ),
                                  height: 1,
                                  width: 1,
                                ),
                              ),
                              hintText: 'Search proxies, protocols...',
                              hintStyle: AppTextStyles.body14.copyWith(
                                color: AppColors.contentSelected,
                              ),
                              border: .none,
                              isDense: true,
                              contentPadding: .zero,
                            ),
                          ),
                        ),
                      ),
                      AppFilter(
                        availableCountries: ['Japan', 'Germany', 'United States'], // с сервера
                        onApply: (result) {
                          result.sortValue;
                          // result.protocols, result.pingOrder,
                          // result.minPing, result.maxPing, result.countries
                        },
                      ),
                    ],
                  ),
                ),
                SubscriptionCard(
                  key: const ValueKey('sub-1'),
                  title: 'Name of subscription provider',
                  serverCount: 4,
                  status: SubscriptionStatus.expired,
                  lastUpdated: DateTime(2026, 7, 5, 19, 24),
                  usedGb: 888,
                  limitGb: 1500,
                  // 1.5 TB в ГБ, или double.infinity для безлимита
                  description:
                      '🚀🚀🚀 user_6636648954_714059, Статус: ⚠ Expired, Дней осталось: 0\n'
                      '⚙️ Протоколы: H2 - Hysteria2, VLESS - Vless Нажмите ℹ️ если не работает VPN! '
                      'Приятного использования! ❤️',
                  serverTiles: const [],
                  onRefresh: () {},
                  onSpeedTest: () {},
                  onMore: () {},
                ),
                SubscriptionCard(
                  key: const ValueKey('sub-2'),
                  title: 'Name of subscription provider',
                  serverCount: 4,
                  status: SubscriptionStatus.expired,
                  lastUpdated: DateTime(2026, 7, 5, 19, 24),
                  usedGb: 888,
                  limitGb: 1500,
                  // 1.5 TB в ГБ, или double.infinity для безлимита
                  description:
                      '🚀🚀🚀 user_6636648954_714059, Статус: ⚠ Expired, Дней осталось: 0\n'
                      '⚙️ Протоколы: H2 - Hysteria2, VLESS - Vless Нажмите ℹ️ если не работает VPN! '
                      'Приятного использования! ❤️',
                  serverTiles: const [],
                  onRefresh: () {},
                  onSpeedTest: () {},
                  onMore: () {},
                ),
                LocalConfigCard(
                  key: const ValueKey('local'),
                  title: 'My servers',
                  serverCount: 4,
                  lastUpdated: DateTime(2026, 7, 5, 19, 24),
                  serverTiles: const [
                    ServerTile(
                      countryFlagEmoji: 'jp.webp',
                      name: 'Tokyo, Japan',
                      protocol: AppServerProtocol.hysteria2,
                      pingMs: 45,
                    ),
                    ServerTile(
                      countryFlagEmoji: 'kr.webp',
                      name: 'Seoul, South Korea',
                      protocol: AppServerProtocol.vless,
                      pingMs: 140,
                    ),
                    ServerTile(
                      countryFlagEmoji: 'de.webp',
                      name: 'Berlin, Germany',
                      protocol: AppServerProtocol.unknown,
                      pingMs: 200,
                    ),
                    ServerTile(
                      countryFlagEmoji: 'de.webp',
                      name: 'Berlin, Germany',
                      protocol: AppServerProtocol.trojan,
                      pingMs: 200,
                    ),
                    ServerTile(
                      countryFlagEmoji: 'cn.webp',
                      name: 'Shanghai, China',
                      protocol: AppServerProtocol.wireguard,
                      pingMs: 300,
                    ),
                    ServerTile(
                      countryFlagEmoji: 'cn.webp',
                      name: 'Shanghai, China',
                      protocol: AppServerProtocol.shadowsocks,
                      pingMs: 300,
                    ),
                  ],
                  onEdit: () {},
                  onSpeedTest: () {},
                  onMore: () {},
                ),
                SizedBox(height: 100.fh),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
