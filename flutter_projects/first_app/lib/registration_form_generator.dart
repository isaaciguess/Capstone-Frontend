import 'package:flutter/material.dart';

class RegistrationFormGenerator extends StatelessWidget {
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
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _receiveEmailUpdates = false;
  bool _isSubmitting = false; // A flag to indicate if the form is currently being submitted.

  // Text editing controllers
  final Map<String, TextEditingController> _controllers = {
    'firstName': TextEditingController(),
    'lastName': TextEditingController(),
    'email': TextEditingController(),
    'phone': TextEditingController(),
    'timeSlot': TextEditingController(),
    'allergies': TextEditingController(),
  };

  // The FieldConfig class is designed to encapsulate the properties of each form field in your registration form.
  // This class serves as a blueprint for creating individual field configurations, making it easier to manage and generate form fields dynamically.
  final List<FieldConfig> _fields = [
    FieldConfig(label: 'First Name', key: 'firstName', validationType: ValidationType.name),
    FieldConfig(label: 'Last Name', key: 'lastName', validationType: ValidationType.name),
    FieldConfig(label: 'Email Address', key: 'email', validationType: ValidationType.email),
    FieldConfig(label: 'Phone Number', key: 'phone', validationType: ValidationType.phone),
    FieldConfig(label: 'Time Slot', key: 'timeSlot', validationType: ValidationType.timeslot),
    FieldConfig(label: 'Allergies / Dietary Requirements', key: 'allergies', validationType: ValidationType.alphabets),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register for\nMelbourne Italian Festa 2024"),
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: <Widget>[
            ..._fields.map((field) => buildTextFormField(field)),
            ListTile(
              title: Text('Receive Email Updates?'),
              trailing: LabeledSwitch(
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
                onPressed: _isSubmitting
                    ? null // Disable the button if the form is currently being submitted
                    : () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isSubmitting = true;
                          }); // Set the flag to indicate that the form is being submitted
                          _submitForm(); // Call the submission method
                        }
                      },
                child: _isSubmitting
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : Text('PROCEED TO PAYMENT'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Mock form submission method
  void _submitForm() async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a network request or processing delay
    setState(() {
      _isSubmitting = false; // Re-enable the button after submission
    });
    // Optionally, navigate to another screen or perform additional actions here
  }

  Padding buildTextFormField(FieldConfig field) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: _controllers[field.key],
        decoration: InputDecoration(
          labelText: field.label,
          border: OutlineInputBorder(),
        ),
        keyboardType: field.validationType == ValidationType.phone
            ? TextInputType.phone
            : TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter ${field.label}';
          } else if (field.validationType == ValidationType.email && !_isValidEmail(value)) {
            return 'Please enter a valid email address';
          } else if (field.validationType == ValidationType.phone && !_isValidPhoneNumber(value)) {
            return 'Please enter a valid phone number';
          } else if (field.validationType == ValidationType.name && !_isValidName(value)) {
            return 'Please enter only alphabets for ${field.label}';
          } else if (field.validationType == ValidationType.timeslot && !_isValidTimeSlot(value)) {
            return 'Time slot must contain only letters and numbers';
          } else if (field.validationType == ValidationType.alphabets && !_isAlphabetsOnly(value)) {
            return 'Please enter only alphabets for ${field.label}';
          }
          return null;
        },
      ),
    );
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  bool _isValidPhoneNumber(String phone) {
    final phoneRegex = RegExp(r'^\d{10}$'); // Simple validation for 10-digit phone numbers
    return phoneRegex.hasMatch(phone);
  }

  // First Name and Last Name Validation: Ensures only alphabet characters are allowed (_isValidName).
  bool _isValidName(String name) {
    final nameRegex = RegExp(r'^[a-zA-Z]+$');
    return nameRegex.hasMatch(name);
  }

  // Time Slot Validation: Accepts only alphanumeric characters (_isValidTimeSlot).
  bool _isValidTimeSlot(String timeSlot) {
    final timeSlotRegex = RegExp(r'^[a-zA-Z0-9]+$');
    return timeSlotRegex.hasMatch(timeSlot);
  }

  // Allergies/Dietary Requirements Validation: Accepts only alphabet characters (_isAlphabetsOnly).
  bool _isAlphabetsOnly(String value) {
    final alphabetsRegex = RegExp(r'^[a-zA-Z\s]+$');
    return alphabetsRegex.hasMatch(value);
  }
}

class FieldConfig {
  final String label; // The display label for the field.
  final String key; // A unique identifier for the field (used for the controller).
  final ValidationType? validationType; // A flag to indicate if this field requires validation.

  FieldConfig({required this.label, required this.key, this.validationType});
}

enum ValidationType { email, phone, name, timeslot, alphabets }

class LabeledSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const LabeledSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  _LabeledSwitchState createState() => _LabeledSwitchState();
}

class _LabeledSwitchState extends State<LabeledSwitch> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: widget.value ? Colors.white : Colors.grey[300],
        ),
        child: Stack(
          children: <Widget>[
            AnimatedAlign(
              alignment: widget.value ? Alignment.centerLeft : Alignment.centerRight,
              duration: Duration(milliseconds: 250),
              curve: Curves.linear,
              child: Container(
                width: 60,
                height: 40,
                decoration: BoxDecoration(
                  color: widget.value
                      ? const Color.fromARGB(255, 102, 89, 175)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: widget.value
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check, color: Colors.white),
                          Text(' Yes',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )
                    : Text('No',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
