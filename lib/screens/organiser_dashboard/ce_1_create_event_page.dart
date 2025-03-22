import 'package:first_app/screens/organiser_dashboard/ce_2_tickets.dart';
import 'package:flutter/material.dart';
import 'package:first_app/models/organizer.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _eventDescriptionController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  String? _selectedEventType = 'SPORTS';  
  DateTime? _startDateTime;
  DateTime? _endDateTime;

  String formatDateTime(DateTime? dateTime) {
  if (dateTime == null) return 'Not selected';
  return '${dateTime.toLocal().toString().split(' ')[0]} ${TimeOfDay.fromDateTime(dateTime).format(context)}';
  }

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
            // Event Name
            TextField(
              controller: _eventNameController,
              decoration: const InputDecoration(
                labelText: 'Event Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Location
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            
            TextField(
            controller: _eventDescriptionController,
            decoration: const InputDecoration(
              labelText: 'Event Description',
              border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
            controller: _capacityController,
            decoration: const InputDecoration(
              labelText: 'Event Capacity',
              border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Dropdown menu for event type
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Event Type',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'SPORTS', child: Text('SPORTS')),
                DropdownMenuItem(value: 'MUSIC', child: Text('MUSIC')),
                DropdownMenuItem(value: 'FOOD', child: Text('FOOD')),
                DropdownMenuItem(value: 'ART', child: Text('ART')),
              ],
                onChanged: (value) {
                setState(() {
                  _selectedEventType = value;
                });
              },
            ),
            const SizedBox(height: 16),
            // Start Date and Time
            Row(
              children: [
                Expanded(
                  child: Text('Starts on: ${formatDateTime(_startDateTime)}'),
                ),
                ElevatedButton(
                  onPressed: _pickStartDateTime,
                  child: const Text('Choose Start Date'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // End Date and Time
            Row(
              children: [
                Expanded(
                  child: Text('Ends on: ${formatDateTime(_endDateTime)}'),
                ),
                ElevatedButton(
                  onPressed: _pickEndDateTime,
                  child: const Text('Choose End Date'),
                ),
              ],
            ),

            const SizedBox(height: 24),
            // Continue button
            // Continue
            ElevatedButton(
              onPressed: _onContinue,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }

Future<void> _pickStartDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _startDateTime ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_startDateTime ?? DateTime.now()),
      );
      
      if (pickedTime != null) {
        setState(() {
          _startDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  // Function to pick end date and time.
  Future<void> _pickEndDateTime() async {
    final DateTime initialDate = _endDateTime ?? _startDateTime ?? DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: _startDateTime ?? DateTime(2020),
      lastDate: DateTime(2030),
    );
    
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_endDateTime ?? DateTime.now()),
      );
      
      if (pickedTime != null) {
        setState(() {
          _endDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

 void _onContinue() {
    final eventName = _eventNameController.text.trim();
    final description = _eventDescriptionController.text.trim();
    final location = _locationController.text.trim();
    final capacity = int.tryParse(_capacityController.text.trim()) ?? 0;

    if (eventName.isEmpty || description.isEmpty || location.isEmpty || _startDateTime == null || _endDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all fields!')),
      );
      return;
    }

    if(capacity <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Capacity must be greater than 0!')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TicketManagementScreen(
          eventName: eventName,
          location: location,
          description: description,
          type: _selectedEventType!,
          capacity: capacity,
          startDateTime: _startDateTime!,
          endDateTime: _endDateTime!,
        ),
      ),
    );
  }
}
