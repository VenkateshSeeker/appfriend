import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlanATripTab extends StatelessWidget {
  const PlanATripTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Plan a Trip',
        style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18),
      ),
    );
  }
}
