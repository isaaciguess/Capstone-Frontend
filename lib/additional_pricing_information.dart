import 'package:flutter/material.dart';
import 'edit_bank_information_page.dart';

class AdditionalPricingOptionsPage extends StatefulWidget {
  final String eventName;
  final String location;
  final DateTime date;
  final TimeOfDay time;
  final double basePrice;
  final bool groupSignup;
  final bool isFree;

  const AdditionalPricingOptionsPage({
    super.key,
    required this.eventName,
    required this.location,
    required this.date,
    required this.time,
    required this.basePrice,
    required this.groupSignup,
    required this.isFree,
  });

  @override
  State<AdditionalPricingOptionsPage> createState() =>
      _AdditionalPricingOptionsPageState();
}

class _AdditionalPricingOptionsPageState
    extends State<AdditionalPricingOptionsPage> {
  bool _concessionRate = false;
  bool _groupDiscount = false;
  bool _ageDiscount = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Additional Pricing Options'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Concession Rate
            ElevatedButton(
              onPressed: () {
                setState(() => _concessionRate = !_concessionRate);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _concessionRate ? Colors.blue : Colors.grey.shade400,
              ),
              child: const Text('Concession Rate'),
            ),
            const SizedBox(height: 16),

            // Group Discount
            ElevatedButton(
              onPressed: () {
                setState(() => _groupDiscount = !_groupDiscount);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _groupDiscount ? Colors.blue : Colors.grey.shade400,
              ),
              child: const Text('Group Discount'),
            ),
            const SizedBox(height: 16),

            // Age Discount
            ElevatedButton(
              onPressed: () {
                setState(() => _ageDiscount = !_ageDiscount);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _ageDiscount ? Colors.blue : Colors.grey.shade400,
              ),
              child: const Text('Age Discount'),
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
    // Navigate to the EditBankInformationPage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditBankInformationPage(
          eventName: widget.eventName,
          location: widget.location,
          date: widget.date,
          time: widget.time,
          basePrice: widget.basePrice,
          groupSignup: widget.groupSignup,
          isFree: widget.isFree,
          concessionRate: _concessionRate,
          groupDiscount: _groupDiscount,
          ageDiscount: _ageDiscount,
        ),
      ),
    );
  }
}
