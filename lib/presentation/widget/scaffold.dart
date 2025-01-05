import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final double appBarBorderHeight;
  final Color appBarBorderColor = Color(0xFFBDBDBD).withAlpha(76);
  final bool centerTitle;

  CustomScaffold({
    super.key,
    required this.title,
    required this.body,
    this.appBarBorderHeight = 1.0,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: centerTitle,
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(appBarBorderHeight),
          child: Container(
            color: appBarBorderColor,
            height: appBarBorderHeight,
          ),
        ),
      ),
      body: body,
    );
  }
}
