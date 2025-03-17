import 'package:first_app/create_event_page..dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Events'),
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
