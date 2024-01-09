import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class AppWidget extends StatelessWidget {

  AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Flutter Firebase Authentication',
        themeMode: ThemeMode.light,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.teal,
          primarySwatch: Colors.teal,
          fontFamily: GoogleFonts.roboto().fontFamily,
        ),
        routerConfig: Modular.routerConfig,);
  }
}
