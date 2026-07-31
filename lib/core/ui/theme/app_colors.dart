import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Semantic colors
  static const success = Color(0xff4ade80);             // цвет для успешного выполнения
  static const warning = Color(0xffffb800);             // цвет для предупреждения
  static const error = Color(0xffff6b6b);               // цвет для ошибки

  // Traffic metrics
  static const download = Color(0xff5cd9d2);            // цвет для скорости скачивания
  static const upload = Color(0xffbf71ff);              // цвет для скорости загрузки
  static const traffic = Color(0xfff5f5f5);             // цвет переданного объема данных

  // Content colors
  static const contentPrimary = Color(0xffffffff);      // заголовки, иконки
  static const contentSecondary = Color(0xffaaaaaa);    // основной текст, иконки
  static const contentSelected = Color(0xffb4b4b4);     // активные элементы
  static const contentDisabled = Color(0xff676767);     // неактивные элементы

  // Ghost button
  static const ghostButtonBorder = Color(0x14ffffff);     // цвет границы
  static const ghostButtonBackground = Color(0x0affffff); // фон кнопки

  // Selected button
  static const selectedButtonBorder = Color(0x52ffffff); // цвет границы
  static const selectedButtonBackground = Color(0x24ffffff); // фон кнопки

  // Surfaces
  static const border = Color(0xff2b2b2b);              // цвет границы
  static const surfaceCard = Color(0xff1c1c1c);         // фон карточки
  static const surfaceNavSelected = Color(0xff191919);  // выбранный пункт меню
  static const surfaceBackground = Color(0xff151515);   // задний фон

  // Protocols
  static const protocolVMess = Color(0xffa855f7);
  static const protocolVLESS = Color(0xff10b981);
  static const protocolTrojan = Color(0xfff59e0b);
  static const protocolHy2 = Color(0xff06b6d4);
  static const protocolShadowsocks = Color(0xff3b82f6);
  static const protocolWG = Color(0xffef4444);

}