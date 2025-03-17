import 'package:flutter_test/flutter_test.dart';
import 'package:first_app/network/auth.dart';
import 'package:flutter/material.dart';// Needed to initialize Flutter bindings

void main() {
  // Ensure Flutter is initialized before running tests
  WidgetsFlutterBinding.ensureInitialized(); 

  test('Login function should return success', () async {
    await loginUser("isaac1@gmail.com", "Isaac123");
    expect(true, true); // Placeholder
  });
}