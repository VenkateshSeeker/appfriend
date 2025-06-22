import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Home',
        style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18),
      ),
    );
  }
}
