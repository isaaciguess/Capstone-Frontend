import 'package:flutter/material.dart';

class EditPriceInformationPage extends StatefulWidget {
  final String eventName;
  final String location;
  final DateTime date;
  final TimeOfDay time;

  const EditPriceInformationPage({
    Key? key,
    required this.eventName,
    required this.location,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  State<EditPriceInformationPage> createState() =>
      _EditPriceInformationPageState();
}

class _EditPriceInformationPageState extends State<EditPriceInformationPage> {
  final TextEditingController _priceController = TextEditingController();

  bool _groupSignup = false; // 'Yes' or 'No'
  bool _isFree = false; // Whether event is free

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Pricing Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Base Price Field
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Base Price',
                border: OutlineInputBorder(),
              ),
              enabled: !_isFree, // disable if event is free
            ),
            const SizedBox(height: 16),

            // Group Signup Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Group Signup'),
                Row(
                  children: [
                    // Yes Button
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _groupSignup = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _groupSignup ? Colors.blue : Colors.grey.shade400,
                      ),
                      child: const Text('Yes'),
                    ),
                    const SizedBox(width: 8),
                    // No Button
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _groupSignup = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            !_groupSignup ? Colors.blue : Colors.grey.shade400,
                      ),
                      child: const Text('No'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // My Event Will Be Free Button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isFree = true;
                  _priceController.text = '0';
                });
              },
              child: const Text('My Event Will Be Free'),
            ),
            const SizedBox(height: 24),

            // Confirm Details Button
            ElevatedButton(
              onPressed: _confirmDetails,
              child: const Text('Confirm Details'),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDetails() {
    final basePrice = _isFree ? 0 : double.tryParse(_priceController.text) ?? 0;
    final groupSignupStatus = _groupSignup ? 'Yes' : 'No';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Event Summary'),
          content: Text(
            'Event Name: ${widget.eventName}\n'
            'Location: ${widget.location}\n'
            'Date: ${widget.date.toLocal()}'.split(' ')[0] + '\n'
            'Time: ${widget.time.format(context)}\n'
            'Base Price: $basePrice\n'
            'Group Signup: $groupSignupStatus\n'
            'Is Free: $_isFree',
          ),
          actions: [
            TextButton(
              onPressed: () {
                // You could navigate back or save the event details here.
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
