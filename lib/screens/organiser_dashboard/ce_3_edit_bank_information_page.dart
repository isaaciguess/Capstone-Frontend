import 'ce_4_create_questions_page.dart';
import 'package:flutter/material.dart';
import 'create_registration_form_page.dart';
import 'package:first_app/models/ticket.dart';

class EditBankInformationPage extends StatefulWidget {
  final String eventName;
  final String location;
  final String description;
  final String type;
  final int capacity;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final List<TicketDTO> tickets;


  const EditBankInformationPage({
    super.key,
    required this.eventName,
    required this.location,
    required this.description,
    required this.type,
    required this.capacity,
    required this.startDateTime,
    required this.endDateTime,
    required this.tickets,  
  });

  @override
  State<EditBankInformationPage> createState() =>
      _EditBankInformationPageState();
}

class _EditBankInformationPageState extends State<EditBankInformationPage> {
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _bsbController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Information'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Account Name
            TextField(
              controller: _accountNameController,
              decoration: const InputDecoration(
                labelText: 'Account Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Account Number
            TextField(
              controller: _accountNumberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Account Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // BSB
            TextField(
              controller: _bsbController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'BSB',
                border: OutlineInputBorder(),
              ),
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

  void _onContinue() {
    final accountName = _accountNameController.text.trim();
    final accountNumber = _accountNumberController.text.trim();
    final bsb = _bsbController.text.trim();

    // Basic validation
    if (accountName.isEmpty || accountNumber.isEmpty || bsb.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all bank fields!')),
      );
      return;
    }

    // Navigate to the CreateRegistrationFormPage with all data
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateEventQuestions(
          eventName: widget.eventName,
          location: widget.location,
          description: widget.description,
          type: widget.type,
          capacity: widget.capacity,
          startDateTime: widget.startDateTime,
          endDateTime: widget.endDateTime,
          tickets: widget.tickets,
          accountName: accountName,
          accountNumber: accountNumber,
          bsb: bsb,
        ),
      ),
    );
  }
}
