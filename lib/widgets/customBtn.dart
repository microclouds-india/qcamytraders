import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/colors.dart';

Widget btn(String txt) {
  return Container(
    decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10))),
    height: 30,
    width: 80,
    child: Center(
      child: Text(
        txt,
        style: GoogleFonts.openSans(
            color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );
}