import 'package:flutter/material.dart';
import 'package:first_app/screens/organiser_dashboard/ce_1_create_event_page.dart';

class OrganiserDashboard extends StatelessWidget {
  const OrganiserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organiser Dashboard'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the Create Event page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateEventPage()),
            );
          },
          child: const Text('Create New Event'),
        ),
      ),
    );
  }
}
