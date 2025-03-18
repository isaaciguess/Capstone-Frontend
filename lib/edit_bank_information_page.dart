import 'package:flutter/material.dart';

class EditBankInformationPage extends StatefulWidget {
  final String eventName;
  final String location;
  final DateTime date;
  final TimeOfDay time;
  final double basePrice;
  final bool groupSignup;
  final bool isFree;
  final bool concessionRate;
  final bool groupDiscount;
  final bool ageDiscount;

  // Group discount details
  final double? discountPerMember;
  final int? memberLimit;
  final bool applyToOtherConcessions;

  const EditBankInformationPage({
    Key? key,
    required this.eventName,
    required this.location,
    required this.date,
    required this.time,
    required this.basePrice,
    required this.groupSignup,
    required this.isFree,
    required this.concessionRate,
    required this.groupDiscount,
    required this.ageDiscount,
    this.discountPerMember,
    this.memberLimit,
    this.applyToOtherConcessions = false,
  }) : super(key: key);

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
    final accountName = _accountNameController.text.trim();
    final accountNumber = _accountNumberController.text.trim();
    final bsb = _bsbController.text.trim();

    if (accountName.isEmpty || accountNumber.isEmpty || bsb.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all bank fields!')),
      );
      return;
    }

    // Show final summary in a dialog (or navigate to a new SummaryPage)
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Event Summary'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Event Name: ${widget.eventName}'),
                Text('Location: ${widget.location}'),
                Text('Date: ${widget.date.toLocal()}'.split(' ')[0]),
                Text('Time: ${widget.time.format(context)}'),
                Text('Base Price: ${widget.basePrice}'),
                Text('Group Signup: ${widget.groupSignup ? "Yes" : "No"}'),
                Text('Is Free: ${widget.isFree}'),
                Text('Concession Rate: ${widget.concessionRate}'),
                Text('Group Discount: ${widget.groupDiscount}'),
                Text('Age Discount: ${widget.ageDiscount}'),

                // If group discount is chosen, show the details
                if (widget.groupDiscount) ...[
                  const SizedBox(height: 8),
                  Text('Discount Per Member: ${widget.discountPerMember ?? 0}'),
                  Text('Member Limit: ${widget.memberLimit ?? 0}'),
                  Text('Apply to Other Concessions: ${widget.applyToOtherConcessions}'),
                ],

                const SizedBox(height: 16),
                Text('Account Name: $accountName'),
                Text('Account Number: $accountNumber'),
                Text('BSB: $bsb'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Save data or navigate away
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
