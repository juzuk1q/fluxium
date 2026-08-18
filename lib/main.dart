import 'package:Fluxium/core/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:vize/vize.dart';
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
     MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: .dark(),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        Vize.init(
          context,
          figmaWidth: 393, // width
          figmaHeight: 852, // height
        );
        return MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: .linear(1)), child: child!);
      },
      home: RootScreen(),
    );
  }
}