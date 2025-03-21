import 'package:flutter/material.dart';

class CreateRegistrationFormPage extends StatefulWidget {
  final String eventName;
  // Include other parameters if you want (e.g., location, date, etc.)

  const CreateRegistrationFormPage({
    super.key,
    required this.eventName, required String location, required bool isFree, required DateTime date, required TimeOfDay time, required double basePrice, required bool groupSignup, required bool groupDiscount, double? concessionDiscountRate, double? discountPerMember, required bool concessionRequiresID, int? memberLimit, required bool applyToOtherConcessions, int? minAge, int? maxAge, double? ageDiscountRate, required bool applyToAllPromotions, required String accountName, required String accountNumber, required String bsb, required bool concessionRate, required bool ageDiscount,
  });

  @override
  State<CreateRegistrationFormPage> createState() =>
      _CreateRegistrationFormPageState();
}

class _CreateRegistrationFormPageState
    extends State<CreateRegistrationFormPage> {
  // Default fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  // Dynamically added fields
  final List<TextEditingController> _additionalFieldControllers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Custom Questionnaire Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // First Name
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Last Name
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Phone Number
            TextField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Additional fields (dynamically added)
            ..._buildAdditionalFields(),

            // Add Another Field button
            TextButton.icon(
              onPressed: _onAddAnotherField,
              icon: const Icon(Icons.add),
              label: const Text('Add Another Field'),
            ),
            const SizedBox(height: 24),

            // CREATE NEW EVENT button
            ElevatedButton(
              onPressed: _onCreateNewEvent,
              child: const Text('CREATE NEW EVENT'),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildAdditionalFields() {
    return _additionalFieldControllers.asMap().entries.map((entry) {
      final index = entry.key;
      final controller = entry.value;

      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: 'Custom Field ${index + 1}',
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => _removeField(index),
            ),
          ),
        ),
      );
    }).toList();
  }

  void _onAddAnotherField() {
    setState(() {
      _additionalFieldControllers.add(TextEditingController());
    });
  }

  void _removeField(int index) {
    setState(() {
      _additionalFieldControllers.removeAt(index);
    });
  }

  void _onCreateNewEvent() {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final phoneNumber = _phoneNumberController.text.trim();

    final additionalFields = _additionalFieldControllers
        .map((c) => c.text.trim())
        .where((text) => text.isNotEmpty)
        .toList();

    // Example: show a summary in a dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Final Event Details'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Event Name: ${widget.eventName}'),
                const SizedBox(height: 8),
                Text('First Name: $firstName'),
                Text('Last Name: $lastName'),
                Text('Phone Number: $phoneNumber'),
                if (additionalFields.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  const Text('Additional Fields:'),
                  for (var field in additionalFields) Text('- $field'),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // For example, pop or navigate away
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
