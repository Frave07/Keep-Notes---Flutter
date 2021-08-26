import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class TextTitle extends StatelessWidget {
  
  final TextEditingController controller;

  const TextTitle({ required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: TextField(
        controller: controller,
        style: GoogleFonts.getFont('Inter'),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Title',
          contentPadding: EdgeInsets.only(left: 10.0)
        ),
      ),
    );
  }
}
