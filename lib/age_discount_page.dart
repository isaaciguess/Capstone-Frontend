import 'package:flutter/material.dart';

class AgeDiscountPage extends StatefulWidget {
  final int? initialMinAge;
  final int? initialMaxAge;
  final double? initialDiscountRate;
  final bool initialApplyToAllPromotions;

  const AgeDiscountPage({
    Key? key,
    this.initialMinAge,
    this.initialMaxAge,
    this.initialDiscountRate,
    this.initialApplyToAllPromotions = false,
  }) : super(key: key);

  @override
  State<AgeDiscountPage> createState() => _AgeDiscountPageState();
}

class _AgeDiscountPageState extends State<AgeDiscountPage> {
  final TextEditingController _minAgeController = TextEditingController();
  final TextEditingController _maxAgeController = TextEditingController();
  final TextEditingController _discountRateController = TextEditingController();

  bool _applyToAllPromotions = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill fields if initial values exist
    if (widget.initialMinAge != null) {
      _minAgeController.text = widget.initialMinAge.toString();
    }
    if (widget.initialMaxAge != null) {
      _maxAgeController.text = widget.initialMaxAge.toString();
    }
    if (widget.initialDiscountRate != null) {
      _discountRateController.text = widget.initialDiscountRate.toString();
    }
    _applyToAllPromotions = widget.initialApplyToAllPromotions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Age Discount'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Min Age
            TextField(
              controller: _minAgeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Minimum Age',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Max Age
            TextField(
              controller: _maxAgeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Maximum Age',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Discount Rate
            TextField(
              controller: _discountRateController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Discount Rate',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Apply to All Promotions Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Apply to All Promotions'),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() => _applyToAllPromotions = true);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _applyToAllPromotions
                            ? Colors.blue
                            : Colors.grey.shade400,
                      ),
                      child: const Text('Yes'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        setState(() => _applyToAllPromotions = false);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: !_applyToAllPromotions
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
    final minAge = int.tryParse(_minAgeController.text) ?? 0;
    final maxAge = int.tryParse(_maxAgeController.text) ?? 0;
    final discountRate = double.tryParse(_discountRateController.text) ?? 0.0;

    Navigator.pop(context, {
      'minAge': minAge,
      'maxAge': maxAge,
      'discountRate': discountRate,
      'applyToAllPromotions': _applyToAllPromotions,
    });
  }
}
