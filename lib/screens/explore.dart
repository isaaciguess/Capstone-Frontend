import 'package:flutter/material.dart';
import 'package:first_app/screens/new_registration_form_generator.dart';

class Explore extends StatelessWidget {
  const Explore({super.key});
  
  @override
  Widget build(BuildContext context) {
    return RegistrationForm(eventId: 2);
  }
}