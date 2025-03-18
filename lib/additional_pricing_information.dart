import 'package:first_app/group_discount.dart';
import 'package:flutter/material.dart';
import 'edit_bank_information_page.dart';
import 'group_discount_page.dart';
import 'concession_rate_page.dart';
import 'age_discount_page.dart';

class AdditionalPricingOptionsPage extends StatefulWidget {
  final String eventName;
  final String location;
  final DateTime date;
  final TimeOfDay time;
  final double basePrice;
  final bool groupSignup;
  final bool isFree;

  const AdditionalPricingOptionsPage({
    Key? key,
    required this.eventName,
    required this.location,
    required this.date,
    required this.time,
    required this.basePrice,
    required this.groupSignup,
    required this.isFree,
  }) : super(key: key);

  @override
  State<AdditionalPricingOptionsPage> createState() =>
      _AdditionalPricingOptionsPageState();
}

class _AdditionalPricingOptionsPageState
    extends State<AdditionalPricingOptionsPage> {
  // Toggles for the three discounts:
  bool _concessionRate = false;
  bool _groupDiscount = false;
  bool _ageDiscount = false;

  // Concession Rate data
  double? _concessionDiscountRate;
  bool _concessionRequiresID = false;

  // Group Discount data
  double? _discountPerMember;
  int? _memberLimit;
  bool _applyToOtherConcessions = false;

  // Age Discount data
  int? _minAge;
  int? _maxAge;
  double? _ageDiscountRate;
  bool _applyToAllPromotions = false;

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
              onPressed: _onConcessionRatePressed,
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
              onPressed: _onAgeDiscountPressed,
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

  // ----------------------------
  // Concession Rate
  Future<void> _onConcessionRatePressed() async {
    setState(() => _concessionRate = true);

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConcessionRatePage(
          initialDiscountRate: _concessionDiscountRate,
          initialRequiresID: _concessionRequiresID,
        ),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _concessionDiscountRate = result['discountRate'] as double;
        _concessionRequiresID = result['requiresID'] as bool;
      });
    }
  }

  // ----------------------------
  // Group Discount
  Future<void> _onGroupDiscountPressed() async {
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
        _discountPerMember = result['discountPerMember'] as double;
        _memberLimit = result['memberLimit'] as int;
        _applyToOtherConcessions = result['applyToOtherConcessions'] as bool;
      });
    }
  }

  // ----------------------------
  // Age Discount
  Future<void> _onAgeDiscountPressed() async {
    setState(() => _ageDiscount = true);

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AgeDiscountPage(
          initialMinAge: _minAge,
          initialMaxAge: _maxAge,
          initialDiscountRate: _ageDiscountRate,
          initialApplyToAllPromotions: _applyToAllPromotions,
        ),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _minAge = result['minAge'] as int;
        _maxAge = result['maxAge'] as int;
        _ageDiscountRate = result['discountRate'] as double;
        _applyToAllPromotions = result['applyToAllPromotions'] as bool;
      });
    }
  }

  // ----------------------------
  // Continue
  void _onContinue() {
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

          // Which discount toggles are selected
          concessionRate: _concessionRate,
          groupDiscount: _groupDiscount,
          ageDiscount: _ageDiscount,

          // Concession data
          concessionDiscountRate: _concessionDiscountRate,
          concessionRequiresID: _concessionRequiresID,

          // Group data
          discountPerMember: _discountPerMember,
          memberLimit: _memberLimit,
          applyToOtherConcessions: _applyToOtherConcessions,

          // Age data
          minAge: _minAge,
          maxAge: _maxAge,
          ageDiscountRate: _ageDiscountRate,
          applyToAllPromotions: _applyToAllPromotions,
        ),
      ),
    );
  }
}
