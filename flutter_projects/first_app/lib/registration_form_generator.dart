import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegistrationFormGenerator extends StatelessWidget {
  const RegistrationFormGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      home: const RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _receiveEmailUpdates = false;
  bool _isSubmitting = false;
  bool _isGroupRegistration = false;
  int _groupSize = 1;

  final List<Map<String, TextEditingController>> _controllers = [];

  final List<FieldConfig> _fields = [
    FieldConfig(label: 'First Name', key: 'firstName', validationType: ValidationType.name),
    FieldConfig(label: 'Last Name', key: 'lastName', validationType: ValidationType.name),
    FieldConfig(label: 'Email Address', key: 'email', validationType: ValidationType.email),
    FieldConfig(label: 'Phone Number', key: 'phone', validationType: ValidationType.phone),
    FieldConfig(label: 'Time Slot', key: 'timeSlot', validationType: ValidationType.timeslot),
    FieldConfig(label: 'Allergies / Dietary Requirements', key: 'allergies', validationType: ValidationType.alphabets),
  ];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _controllers.clear();
    for (int i = 0; i < _groupSize; i++) {
      _controllers.add({
        'firstName': TextEditingController(),
        'lastName': TextEditingController(),
        'email': TextEditingController(),
        'phone': TextEditingController(),
        'timeSlot': TextEditingController(),
        'allergies': TextEditingController(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register for\nMelbourne Italian Festa 2024"),
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: <Widget>[
            SwitchListTile(
              title: const Text("Group Registration"),
              value: _isGroupRegistration,
              onChanged: (bool value) {
                setState(() {
                  _isGroupRegistration = value;
                  if (_isGroupRegistration) {
                    _initializeControllers();
                  }
                });
              },
            ),
            if (_isGroupRegistration)
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Number of People in Group'),
                onChanged: (value) {
                  setState(() {
                    _groupSize = int.tryParse(value) ?? 1;
                    _initializeControllers();
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null || int.parse(value) < 1) {
                    return 'Enter a valid group size';
                  }
                  return null;
                },
              ),
            ...List.generate(
              _groupSize,
              (index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Member ${index + 1}', style: TextStyle(fontWeight: FontWeight.bold)),
                  ..._fields.map((field) => buildTextFormField(field, index)),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            ListTile(
              title: const Text('Receive Email Updates?'),
              trailing: Switch(
                value: _receiveEmailUpdates,
                onChanged: (bool value) {
                  setState(() {
                    _receiveEmailUpdates = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 102, 89, 175),
                  foregroundColor: Colors.white,
                ),
                onPressed: _isSubmitting ? null : _submitForm,
                child: _isSubmitting
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text('PROCEED TO PAYMENT'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  Padding buildTextFormField(FieldConfig field, int memberIndex) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: _controllers[memberIndex][field.key],
        decoration: InputDecoration(
          labelText: field.label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: field.validationType == ValidationType.phone
            ? TextInputType.phone
            : TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter ${field.label}';
          }

          if (field.validationType == ValidationType.phone) {
            // Phone number validation: checks if it contains only digits and has 10 digits.
            final phoneRegex = RegExp(r'^\d{10}$');
            if (!phoneRegex.hasMatch(value)) {
              return 'Please enter valid phone number (10 digits)';
            }
          }

          if (field.validationType == ValidationType.email) {
            // Email validation: checks if the email format is valid.
            final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
            if (!emailRegex.hasMatch(value)) {
              return 'Please enter valid email address';
            }
          }

          return null;
        },
      ),
    );
  }
}

class FieldConfig {
  final String label;
  final String key;
  final ValidationType? validationType;

  FieldConfig({required this.label, required this.key, this.validationType});
}

enum ValidationType { email, phone, name, timeslot, alphabets }
