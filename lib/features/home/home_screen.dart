import 'package:Fluxium/core/ui/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:Fluxium/core/ui/theme/app_colors.dart';
import 'package:Fluxium/core/ui/widgets/app_top_bar.dart';
import 'package:Fluxium/core/ui/widgets/home/app_status.dart';
import 'package:Fluxium/core/ui/widgets/home/app_button.dart';
import 'package:Fluxium/core/ui/widgets/home/app_ip_widget.dart';
import 'package:Fluxium/core/ui/widgets/home/app_metric_widget.dart';
import 'package:Fluxium/core/ui/widgets/home/app_connect_button.dart';
import 'package:vize/vize.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.surfaceBackground,
      appBar: AppTopBar(
        leftText: 'v/1.1.1',
        textStyle: AppTextStyles.body15.copyWith(color: AppColors.contentDisabled, fontWeight: .w700, height: 4),
        centerWidget: AppStatus.isConnected(),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: pa(0),
        child: SafeArea(
          child: Padding(
            padding: .only(bottom: 2),
            child: Column(
              mainAxisAlignment: .end,
              crossAxisAlignment: .center,
              children: [
                Spacer(),
                ConnectButton(),
                Spacer(),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    AppButton(icon: 'assets/icons/plus.svg', label: 'Add'),
                    AppButton(icon: 'assets/icons/qrcode.svg', label: 'QR-Code'),
                  ],
                ),
                IPWidget(icon: 'assets/icons/eye_show.svg'),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    MetricWidget(
                      icon: 'assets/icons/download.svg',
                      text: 'download',
                      metricValue: '1337',
                      metricUnit: 'mb/s',
                      color: AppColors.download,
                    ),
                    MetricWidget(
                      icon: 'assets/icons/upload.svg',
                      text: 'upload',
                      metricValue: '676.7',
                      metricUnit: 'mb/s',
                      color: AppColors.upload,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    MetricWidget(
                      icon: 'assets/icons/latency.svg',
                      text: 'latency',
                      metricValue: '12',
                      metricUnit: 'ms',
                      color: AppColors.success,
                    ),
                    MetricWidget(
                      icon: 'assets/icons/traffic.svg',
                      text: 'traffic',
                      metricValue: '8.12',
                      metricUnit: 'tb',
                      color: AppColors.traffic,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
