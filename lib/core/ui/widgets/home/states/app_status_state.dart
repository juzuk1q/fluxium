import 'package:flutter/material.dart';
import 'package:Fluxium/core/ui/theme/app_colors.dart';

enum StatusState {
  isConnected(
    status: 'Connected',
    icon: 'assets/icons/point_filled.svg',
    color: AppColors.contentPrimary,
  ),
  notConnected(
    status: 'Not connected',
    icon: 'assets/icons/point_outline.svg',
    color: AppColors.contentDisabled,
  );

  final String status;
  final String icon;
  final Color color;

  const StatusState({required this.status, required this.icon, required this.color});
}