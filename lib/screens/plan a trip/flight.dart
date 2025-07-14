import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(
  const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FlightBookingScreen(),
  ),
);

class FlightBookingScreen extends StatefulWidget {
  const FlightBookingScreen({super.key});

  @override
  State<FlightBookingScreen> createState() => _FlightBookingScreenState();
}

class _FlightBookingScreenState extends State<FlightBookingScreen> {
  List flights = [];
  bool isLoading = false;

  final TextEditingController _fromCityController = TextEditingController();
  final TextEditingController _toCityController = TextEditingController();

  final Map<String, String> cityIataMap = {
    'paris': 'CDG',
    'new york': 'JFK',
    'london': 'LHR',
    'dubai': 'DXB',
    'singapore': 'SIN',
    'delhi': 'DEL',
    'mumbai': 'BOM',
    'amsterdam': 'AMS',
    'los angeles': 'LAX',
    'frankfurt': 'FRA',
  };

  Future<void> fetchFlights() async {
    final fromCity = _fromCityController.text.trim().toLowerCase();
    final toCity = _toCityController.text.trim().toLowerCase();

    if (!cityIataMap.containsKey(fromCity) ||
        !cityIataMap.containsKey(toCity)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('City not available in supported list.')),
      );
      return;
    }

    final fromIATA = cityIataMap[fromCity]!;
    final toIATA = cityIataMap[toCity]!;

    setState(() {
      isLoading = true;
      flights = [];
    });

    const apiKey = '49d4f352d32e99621c9176e039d94812';
    final url =
        'http://api.aviationstack.com/v1/flights?access_key=$apiKey&dep_iata=$fromIATA&arr_iata=$toIATA';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          flights = data['data'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load flights: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F22),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0F22),
        elevation: 0,
        title: Text(
          "Let's book your\nnext flight",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _cityTextField(
                    controller: _fromCityController,
                    label: 'From City',
                    icon: Icons.flight_takeoff,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _cityTextField(
                    controller: _toCityController,
                    label: 'To City',
                    icon: Icons.flight_land,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                icon: const Icon(Icons.search, color: Colors.white),
                label: const Text('Search Flights'),
                onPressed: fetchFlights,
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : flights.isEmpty
                  ? Center(
                      child: Text(
                        'No flights found.\nEnter cities and tap Search.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: Colors.white54,
                          fontSize: 16,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: flights.length,
                      itemBuilder: (context, index) {
                        final flight = flights[index];
                        final departure = flight['departure'];
                        final arrival = flight['arrival'];
                        final airline = flight['airline'];
                        final status = flight['flight_status'];

                        return flightCard(
                          timeFrom: departure['scheduled'] != null
                              ? departure['scheduled'].substring(11, 16)
                              : 'N/A',
                          from: departure['iata'] ?? 'N/A',
                          to: arrival['iata'] ?? 'N/A',
                          timeTo: arrival['scheduled'] != null
                              ? arrival['scheduled'].substring(11, 16)
                              : 'N/A',
                          duration: '—',
                          transfers: status,
                          price: '\$${(100 + index * 5).toStringAsFixed(2)}',
                          airlineName: airline['name'] ?? 'Unknown Airline',
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cityTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      style: GoogleFonts.poppins(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        filled: true,
        fillColor: const Color(0xFF1B2238),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
      ),
      textCapitalization: TextCapitalization.words,
    );
  }

  Widget flightCard({
    required String timeFrom,
    required String from,
    required String to,
    required String timeTo,
    required String duration,
    required String transfers,
    required String price,
    required String airlineName,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1B2238),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                timeFrom,
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_right_alt, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                timeTo,
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
              ),
              const Spacer(),
              Text(
                airlineName,
                style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                '$from → $to',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                price,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(duration, style: GoogleFonts.poppins(color: Colors.white70)),
              const SizedBox(width: 12),
              Text(
                transfers,
                style: GoogleFonts.poppins(color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
