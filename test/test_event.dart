import 'package:flutter_test/flutter_test.dart';
import 'package:first_app/network/event.dart';
import 'package:flutter/material.dart';// Needed to initialize Flutter bindings


void main() {
  // Ensure Flutter is initialized before running tests
  WidgetsFlutterBinding.ensureInitialized(); 
  test('Test Get all events', () async {
    await getAllEvents();
    expect(true, true);
  });

  test('Test get Event by id', () async {
    await getEventById(1);
    expect(true, true);
  });

  test()
}