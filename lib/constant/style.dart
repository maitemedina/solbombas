import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Styles {
  static TextStyle hyperlink = GoogleFonts.sourceSansPro(
      textStyle: const TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline
      )
  );

  static TextStyle heading7 = GoogleFonts.sourceSansPro(
      textStyle: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.normal
      )
  );

  static TextStyle heading6 = GoogleFonts.sourceSansPro(
      textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
      )
  );

  static TextStyle heading5 = GoogleFonts.sourceSansPro(
      textStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold
      )
  );

  static TextStyle heading4 = GoogleFonts.sourceSansPro(
      textStyle: const TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
      )
  );

  static TextStyle heading3 = GoogleFonts.sourceSansPro(
      textStyle: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      )
  );

  static var heading2 = GoogleFonts.sourceSansPro(
      textStyle: const TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.bold
      )
  );

  static var heading1 = GoogleFonts.sourceSansPro(
      textStyle: const TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.bold
      )
  );

  static var Aa = GoogleFonts.sourceSansPro(
      textStyle: const TextStyle(
          fontSize: 80,
          fontWeight: FontWeight.w300
      )
  );

  static TextStyle lead = GoogleFonts.sourceSansPro(
      textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold
      )
  );

  static TextStyle leadN = GoogleFonts.sourceSansPro(
      textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal
      )
  );

  static TextStyle textBold = GoogleFonts.sourceSansPro(
      textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold
      )
  );

  static TextStyle textRegular = GoogleFonts.sourceSansPro(
      textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal
      )
  );

  static TextStyle textThin = GoogleFonts.sourceSansPro(
      textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w100
      )
  );

  static TextStyle tiny = GoogleFonts.sourceSansPro(
      textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500
      )
  );

  static TextStyle small = GoogleFonts.sourceSansPro(
      textStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w100
      )
  );
}