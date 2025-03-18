import 'package:flutter/material.dart';

class ConcessionRatePage extends StatefulWidget {
  final double? initialDiscountRate;
  final bool initialRequiresID;

  const ConcessionRatePage({
    Key? key,
    this.initialDiscountRate,
    this.initialRequiresID = false,
  }) : super(key: key);

  @override
  State<ConcessionRatePage> createState() => _ConcessionRatePageState();
}

class _ConcessionRatePageState extends State<ConcessionRatePage> {
  final TextEditingController _discountRateController = TextEditingController();
  bool _requiresID = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill with initial values if provided
    if (widget.initialDiscountRate != null) {
      _discountRateController.text = widget.initialDiscountRate.toString();
    }
    _requiresID = widget.initialRequiresID;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Concession Rate'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Concession Discount Rate
            TextField(
              controller: _discountRateController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Concession Discount Rate',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Requires ID Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Requires ID'),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() => _requiresID = true);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _requiresID ? Colors.blue : Colors.grey.shade400,
                      ),
                      child: const Text('Yes'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        setState(() => _requiresID = false);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            !_requiresID ? Colors.blue : Colors.grey.shade400,
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
    final discountRate = double.tryParse(_discountRateController.text) ?? 0.0;

    Navigator.pop(context, {
      'discountRate': discountRate,
      'requiresID': _requiresID,
    });
  }
}
