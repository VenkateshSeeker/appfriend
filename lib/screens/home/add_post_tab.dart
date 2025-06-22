import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPostTab extends StatelessWidget {
  const AddPostTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Add Post',
        style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18),
      ),
    );
  }
}
