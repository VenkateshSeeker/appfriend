import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Search',
        style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18),
      ),
    );
  }
}
