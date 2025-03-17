import 'dart:convert';
import 'dart:ffi';
import "package:first_app/network/dio_client.dart";


//Implemented
Future<void> loginUser(String email, String password) async {
  try {
    final response = await dioClient.dio.post("/auth/login",
      data: {"email": "isaac1@gmail.com", "password": "Isaac123"},
    );

    if (response.statusCode == 200) {
      print("Login successful!");
    } else {
      print("Login failed: ${response.data}");
    }
  } catch (error) {
    print("Login error: $error");
  }
}