import 'package:flutter/material.dart';
import 'flight.dart';

class PlanATripScreen extends StatelessWidget {
  const PlanATripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Plan a Trip'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          BookingCard(
            icon: Icons.flight_takeoff,
            title: 'Book a Flight',
            subtitle: 'Find and book flights for your trip',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FlightBookingScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          BookingCard(
            icon: Icons.train,
            title: 'Book a Train',
            subtitle: 'Check train schedules and book tickets',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TrainBookingScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          BookingCard(
            icon: Icons.hotel,
            title: 'Book a Hotel',
            subtitle: 'Reserve comfortable hotels for your stay',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HotelBookingScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const BookingCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurple, size: 34),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

// Removed local FlightBookingScreen. Now using the imported one from flight.dart.

class TrainBookingScreen extends StatelessWidget {
  const TrainBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Book a Train'),
      ),
      body: const Center(
        child: Text(
          'Train Booking Screen (Add your form or API integration here)',
        ),
      ),
    );
  }
}

class HotelBookingScreen extends StatelessWidget {
  const HotelBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Book a Hotel'),
      ),
      body: const Center(
        child: Text(
          'Hotel Booking Screen (Add your form or API integration here)',
        ),
      ),
    );
  }
}
