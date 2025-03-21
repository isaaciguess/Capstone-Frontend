import 'additional_pricing_information.dart';
import 'package:flutter/material.dart';

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
            // Base Price
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Base Price',
                border: OutlineInputBorder(),
              ),
              enabled: !_isFree,
            ),
            const SizedBox(height: 16),

            // Group Signup Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Group Signup'),
                Row(
                  children: [
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

            // Free Event
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

  void _onContinue() {
    // Determine the final base price
    final basePrice = _isFree ? 0 : double.tryParse(_priceController.text) ?? 0;

    // Navigate to AdditionalPricingOptionsPage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdditionalPricingOptionsPage(
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
