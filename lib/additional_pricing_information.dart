import 'package:first_app/group_discount.dart';
import 'package:flutter/material.dart';
import 'edit_bank_information_page.dart';
import 'group_discount_page.dart';

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

  // Store group discount details (entered on the GroupDiscountPage).
  double? _discountPerMember;
  int? _memberLimit;
  bool _applyToOtherConcessions = false;

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
              onPressed: _onGroupDiscountPressed,
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
                backgroundColor: _ageDiscount ? Colors.blue : Colors.grey.shade400,
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

  /// When "Group Discount" is pressed, navigate to the GroupDiscountPage.
  /// After user fills out details and taps Continue, we pop back with data.
  Future<void> _onGroupDiscountPressed() async {
    // Mark groupDiscount as selected
    setState(() => _groupDiscount = true);

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GroupDiscountPage(
          initialDiscountPerMember: _discountPerMember,
          initialMemberLimit: _memberLimit,
          initialApplyToOtherConcessions: _applyToOtherConcessions,
        ),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        // Update local variables with data from GroupDiscountPage
        _discountPerMember = result['discountPerMember'] as double;
        _memberLimit = result['memberLimit'] as int;
        _applyToOtherConcessions = result['applyToOtherConcessions'] as bool;
      });
    }
  }

  void _onContinue() {
    // Navigate to the EditBankInformationPage, passing along all data.
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

          // Pass the group discount details if user selected them
          discountPerMember: _discountPerMember,
          memberLimit: _memberLimit,
          applyToOtherConcessions: _applyToOtherConcessions,
        ),
      ),
    );
  }
}
