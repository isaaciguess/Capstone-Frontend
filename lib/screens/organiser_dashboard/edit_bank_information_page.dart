import 'questions_answer.dart';
import 'package:flutter/material.dart';
import 'create_registration_form_page.dart';

class EditBankInformationPage extends StatefulWidget {
  // Basic event info
  final String eventName;
  final String location;
  final DateTime date;
  final TimeOfDay time;
  final double basePrice;
  final bool groupSignup;
  final bool isFree;

  // Additional pricing toggles
  final bool concessionRate;
  final bool groupDiscount;
  final bool ageDiscount;

  // Concession data
  final double? concessionDiscountRate;
  final bool concessionRequiresID;

  // Group data
  final double? discountPerMember;
  final int? memberLimit;
  final bool applyToOtherConcessions;

  // Age data
  final int? minAge;
  final int? maxAge;
  final double? ageDiscountRate;
  final bool applyToAllPromotions;

  const EditBankInformationPage({
    super.key,
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
    this.concessionDiscountRate,
    this.concessionRequiresID = false,
    this.discountPerMember,
    this.memberLimit,
    this.applyToOtherConcessions = false,
    this.minAge,
    this.maxAge,
    this.ageDiscountRate,
    this.applyToAllPromotions = false,
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
        builder: (context) => CreateRegistrationFormPage(
          eventName: widget.eventName,
          location: widget.location,
          date: widget.date,
          time: widget.time,
          basePrice: widget.basePrice,
          groupSignup: widget.groupSignup,
          isFree: widget.isFree,
          concessionRate: widget.concessionRate,
          groupDiscount: widget.groupDiscount,
          ageDiscount: widget.ageDiscount,
          concessionDiscountRate: widget.concessionDiscountRate,
          concessionRequiresID: widget.concessionRequiresID,
          discountPerMember: widget.discountPerMember,
          memberLimit: widget.memberLimit,
          applyToOtherConcessions: widget.applyToOtherConcessions,
          minAge: widget.minAge,
          maxAge: widget.maxAge,
          ageDiscountRate: widget.ageDiscountRate,
          applyToAllPromotions: widget.applyToAllPromotions,
          accountName: accountName,
          accountNumber: accountNumber,
          bsb: bsb,
        ),
      ),
    );
  }
}
