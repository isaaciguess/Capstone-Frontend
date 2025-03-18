import 'package:flutter/material.dart';

class GroupDiscountPage extends StatefulWidget {
  final double? initialDiscountPerMember;
  final int? initialMemberLimit;
  final bool initialApplyToOtherConcessions;

  const GroupDiscountPage({
    Key? key,
    this.initialDiscountPerMember,
    this.initialMemberLimit,
    this.initialApplyToOtherConcessions = false,
  }) : super(key: key);

  @override
  State<GroupDiscountPage> createState() => _GroupDiscountPageState();
}

class _GroupDiscountPageState extends State<GroupDiscountPage> {
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _memberLimitController = TextEditingController();
  bool _applyToOtherConcessions = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill fields if we have initial values
    if (widget.initialDiscountPerMember != null) {
      _discountController.text = widget.initialDiscountPerMember.toString();
    }
    if (widget.initialMemberLimit != null) {
      _memberLimitController.text = widget.initialMemberLimit.toString();
    }
    _applyToOtherConcessions = widget.initialApplyToOtherConcessions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Additional Pricing Options - Group'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Discount Per Member
            TextField(
              controller: _discountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Discount Per Member',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Member Limit
            TextField(
              controller: _memberLimitController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Member Limit',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Apply to other concessions toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Apply to other concessions'),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() => _applyToOtherConcessions = true);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _applyToOtherConcessions
                            ? Colors.blue
                            : Colors.grey.shade400,
                      ),
                      child: const Text('Yes'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        setState(() => _applyToOtherConcessions = false);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: !_applyToOtherConcessions
                            ? Colors.blue
                            : Colors.grey.shade400,
                      ),
                      child: const Text('No'),
                    ),
                  ],
                ),
              ],
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
    // Parse user inputs
    final discountPerMember =
        double.tryParse(_discountController.text) ?? 0.0;
    final memberLimit =
        int.tryParse(_memberLimitController.text) ?? 0;

    // Pop back to AdditionalPricingOptionsPage with the entered data
    Navigator.pop(context, {
      'discountPerMember': discountPerMember,
      'memberLimit': memberLimit,
      'applyToOtherConcessions': _applyToOtherConcessions,
    });
  }
}
