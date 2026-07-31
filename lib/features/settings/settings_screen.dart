import 'package:flutter/material.dart';
import 'package:Fluxium/core/ui/theme/app_colors.dart';
import 'package:Fluxium/core/ui/widgets/app_top_bar.dart';
import 'package:Fluxium/core/ui/widgets/app_bottom_bar.dart';
import 'package:Fluxium/core/ui/widgets/home/app_status.dart';
import 'package:Fluxium/core/ui/widgets/home/app_button.dart';
import 'package:Fluxium/core/ui/widgets/home/app_ip_widget.dart';
import 'package:Fluxium/core/ui/widgets/home/app_metric_widget.dart';
import 'package:Fluxium/core/ui/widgets/home/app_connect_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.surfaceBackground,
      appBar: AppTopBar(
        leftText: 'Settings',
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(

        ),
      ),
    );
  }
}
