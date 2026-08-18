import 'package:Fluxium/core/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:vize/vize.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false,
      statusBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      theme: .dark(),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        Vize.init(
          context,
          figmaWidth: 393, // width
          figmaHeight: 852, // height
        );
        return MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: .linear(1)), child: DevicePreview.appBuilder(context, child));
      },
      home: RootScreen(),
    );
  }
}
