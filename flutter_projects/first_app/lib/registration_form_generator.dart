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
    FieldConfig(label: 'First Name', key: 'firstName'),
    FieldConfig(label: 'Last Name', key: 'lastName'),
    FieldConfig(label: 'Email Address', key: 'email', validationType: ValidationType.email),
    FieldConfig(label: 'Phone Number', key: 'phone', validationType: ValidationType.phone),
    FieldConfig(label: 'Time Slot', key: 'timeSlot'),
    FieldConfig(label: 'Allergies / Dietary Requirements', key: 'allergies'),
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process data or navigate to the payment screen
                  }
                },
                child: Text('PROCEED TO PAYMENT'),
              ),
            ),
          ],
        ),
      ),
    );
  }
//FieldConfig Class: Represents each form field, with properties for label, key, and validationType.

//List of Fields: The _fields list holds the configurations for each form field.

//Dynamic Form Generation: The buildTextFormField method is now called in a map function, iterating over the _fields list to generate the form fields dynamically.

  Padding buildTextFormField(FieldConfig field) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: _controllers[field.key],
        decoration: InputDecoration(
          labelText: field.label,
          border: OutlineInputBorder(),
        ),
        keyboardType: field.validationType == ValidationType.phone ? TextInputType.phone : TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter ${field.label}';
          } else if (field.validationType == ValidationType.email && !_isValidEmail(value)) {
            return 'Please enter a valid email address';
          } else if (field.validationType == ValidationType.phone && !_isValidPhoneNumber(value)) {
            return 'Please enter a valid phone number';
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
}
  // The FieldConfig class is designed to encapsulate the properties of each form field in your registration form.
  // This class serves as a blueprint for creating individual field configurations, making it easier to manage and generate form fields dynamically.
class FieldConfig {
  final String label;   // The display label for the field.
  final String key;   // A unique identifier for the field (used for the controller).
  final ValidationType? validationType;  //A flag to indicate if this field requires  validation.

  FieldConfig({required this.label, required this.key, this.validationType});
}

enum ValidationType { email, phone }

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