import 'package:flutter/material.dart';
import 'edit_price_information_page.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({Key? key}) : super(key: key);

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  // Controllers for text fields
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  // Variables to store selected date and time
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Event'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Event Name Field
            TextField(
              controller: _eventNameController,
              decoration: const InputDecoration(
                labelText: 'Event Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Location Field
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Select Date
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No date chosen!'
                        : 'Date: ${_selectedDate!.toLocal()}'.split(' ')[0],
                  ),
                ),
                ElevatedButton(
                  onPressed: _pickDate,
                  child: const Text('Choose Date'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Select Time
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedTime == null
                        ? 'No time chosen!'
                        : 'Time: ${_selectedTime!.format(context)}',
                  ),
                ),
                ElevatedButton(
                  onPressed: _pickTime,
                  child: const Text('Choose Time'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Continue Button
            ElevatedButton(
              onPressed: _onContinue,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _onContinue() {
    final eventName = _eventNameController.text.trim();
    final location = _locationController.text.trim();
    final date = _selectedDate;
    final time = _selectedTime;

    // Basic validation
    if (eventName.isEmpty || location.isEmpty || date == null || time == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all fields!')),
      );
      return;
    }

    // Navigate to the Edit Price Information Page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPriceInformationPage(
          eventName: eventName,
          location: location,
          date: date,
          time: time,
        ),
      ),
    );
  }
}
