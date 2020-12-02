import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bloc Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.ubuntu().fontFamily,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
