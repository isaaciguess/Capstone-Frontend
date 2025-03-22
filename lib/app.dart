import 'package:flutter/material.dart';
import 'screens/organiser_dashboard/event_details_page.dart';

class BasicReportGenerator extends StatelessWidget {
  const BasicReportGenerator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Details',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const EventDetailsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}