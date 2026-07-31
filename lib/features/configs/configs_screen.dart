import 'package:Fluxium/core/data/models/protocol.dart';
import 'package:Fluxium/core/ui/theme/app_text_styles.dart';
import 'package:Fluxium/core/ui/widgets/configs/app_local.dart';
import 'package:Fluxium/core/ui/widgets/configs/app_server_card.dart';
import 'package:Fluxium/core/ui/widgets/configs/app_subscription_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vize/vize.dart';
import 'package:Fluxium/core/ui/theme/app_colors.dart';
import 'package:Fluxium/core/ui/widgets/app_top_bar.dart';
import 'package:Fluxium/core/ui/widgets/home/app_icon_button.dart';

class ConfigsScreen extends StatefulWidget {
  const ConfigsScreen({super.key});

  @override
  State<ConfigsScreen> createState() => _ConfigsScreenState();
}

class _ConfigsScreenState extends State<ConfigsScreen> {
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
          AppIconButton(icon: 'assets/icons/plus.svg'),
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
                  margin: po(b: 6, l: 20, r: 20, t: 0),
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
                              prefixIcon: SvgPicture.asset(
                                'assets/icons/search.svg',
                                color: AppColors.contentSelected,
                                height: 12,
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
                      SizedBox(width: 6),
                      AppIconButton(icon: 'assets/icons/filter.svg', height: 15), // todo: recode
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
                      countryFlagEmoji: '🇯🇵',
                      name: 'Tokyo, Japan',
                      protocol: AppServerProtocol.hysteria2,
                      pingMs: 45,
                    ),
                    ServerTile(
                      countryFlagEmoji: '🇰🇷',
                      name: 'Seoul, South Korea',
                      protocol: AppServerProtocol.vless,
                      pingMs: 140,
                    ),
                    ServerTile(
                      countryFlagEmoji: '🇩🇪',
                      name: 'Berlin, Germany',
                      protocol: AppServerProtocol.unknown,
                      pingMs: 200,
                    ),
                    ServerTile(
                      countryFlagEmoji: '🇩🇪',
                      name: 'Berlin, Germany',
                      protocol: AppServerProtocol.trojan,
                      pingMs: 200,
                    ),
                    ServerTile(
                      countryFlagEmoji: '🇨🇳',
                      name: 'Shanghai, China',
                      protocol: AppServerProtocol.wireguard,
                      pingMs: 300,
                    ),
                    ServerTile(
                      countryFlagEmoji: '🇨🇳',
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
