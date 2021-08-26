import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFrave extends StatelessWidget
{
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextOverflow textOverflow;
  final int maxLine;

  const TextFrave({
    required this.text, 
    this.fontSize = 18, 
    this.color = Colors.black, 
    this.fontWeight = FontWeight.normal,
    this.textOverflow = TextOverflow.visible,
    this.maxLine = 1
  });

  @override
  Widget build(BuildContext context)
  {
    return Text(
      text,
      maxLines: maxLine,
      overflow: textOverflow,
      style: GoogleFonts.getFont('Inter', fontSize: fontSize, color: color, fontWeight: fontWeight)
    );
  }
}