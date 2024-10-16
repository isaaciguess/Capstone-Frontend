import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _timeSlotController = TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();

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
            buildTextFormField(_firstNameController, 'First Name', 12),
            buildTextFormField(_lastNameController, 'Last Name', 12),
            buildTextFormField(_emailController, 'Email Address', 12, emailValidation: true),
            buildTextFormField(_phoneController, 'Phone Number', 12, phoneValidation: true),
            buildTextFormField(_timeSlotController, 'Time Slot', 12),
            buildTextFormField(_allergiesController, 'Allergies / Dietary Requirements', 12),
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

  Padding buildTextFormField(TextEditingController controller, String label, double spacing,
      {String? hint, bool emailValidation = false, bool phoneValidation = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: spacing),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(),
        ),
        keyboardType: phoneValidation ? TextInputType.phone : TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          } else if (emailValidation && !_isValidEmail(value)) {
            return 'Please enter a valid email address';
          } else if (phoneValidation && !_isValidPhoneNumber(value)) {
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
