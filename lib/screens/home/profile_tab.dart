import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile',
        style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18),
      ),
    );
  }
}
