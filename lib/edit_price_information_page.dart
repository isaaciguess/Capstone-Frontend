import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'edit_bank_information_page.dart' as editBankPage2;

class EditPriceInformationPage extends StatefulWidget {
  final String eventName;
  final String location;
  final DateTime date;
  final TimeOfDay time;

  const EditPriceInformationPage({
    super.key,
    required this.eventName,
    required this.location,
    required this.date,
    required this.time,
  });

  @override
  State<EditPriceInformationPage> createState() =>
      _EditPriceInformationPageState();
}

class _EditPriceInformationPageState extends State<EditPriceInformationPage> {
  final TextEditingController _priceController = TextEditingController();
  bool _groupSignup = false;
  bool _isFree = false;

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
                        setState(() => _groupSignup = true);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _groupSignup
                            ? Colors.blue
                            : Colors.grey.shade400,
                      ),
                      child: const Text('Yes'),
                    ),
                    const SizedBox(width: 8),
                    // No Button
                    ElevatedButton(
                      onPressed: () {
                        setState(() => _groupSignup = false);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: !_groupSignup
                            ? Colors.blue
                            : Colors.grey.shade400,
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
    // Determine the final base price
    final basePrice = _isFree ? 0 : double.tryParse(_priceController.text) ?? 0;

    // Navigate to the Edit Bank Information Page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => editBankPage2.EditBankInformationPage(
          eventName: widget.eventName,
          location: widget.location,
          date: widget.date,
          time: widget.time,
          basePrice: basePrice.toDouble(),
          groupSignup: _groupSignup,
          isFree: _isFree,
        ),
      ),
    );
  }
}
