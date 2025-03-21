import 'dart:convert';
import 'dart:ffi';
import "package:first_app/network/dio_client.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:first_app/models/user.dart";

// TO DO NOT USE PRINTS FOR ERROR HANDLING
// TO DO SECURE STORAGE FOR ACCESS TOKEN
String? accessToken;

//Implemented
Future<void> loginUser(String email, String password) async {
  try {
    final response = await dioClient.dio.post(
      "/auth/login",
      data: {"email": email, "password": password},
    );
    if (response.data["success"]) {
      final Map<String, dynamic> responseData = response.data;
      final String newAccessToken = responseData["data"]?["accessToken"];
      handleAccessToken(newAccessToken);
    } else {
      print("Login failed: ${response.data}");
    }
  } catch (error) {
    print("Login error: $error");
  }
}

void handleAccessToken(String? newAccessToken) async {
  if (newAccessToken != null) {
    accessToken == newAccessToken
        ? print("Access Token the same.")
        : print("Access Token different.");
    accessToken = newAccessToken;
    print("Login successful! Access Token stored.");
  } else {
    print("Error: Access Token not found in response.");
  }
}

Future<void> refreshToken() async {
  try {
    //await checkCookies();
    final response = await dioClient.dio.post("/auth/refresh-token");

    if (response.data["success"]) {
      final Map<String, dynamic> responseData = response.data;
      final String newAccessToken = responseData["data"]?["accessToken"];
      handleAccessToken(newAccessToken);
    } else {
      print("Refresh token failed: ${response.data}");
    }
  } catch (error) {
    print("Refresh token error: $error");
  }
}

// TO DO ADD PROPER SUCESSFUL RESPONSE HANDLING
Future<void> registerUser(RegisterUserDTO data) async {
  try {
    final response =
        await dioClient.dio.post("/auth/register", data: data.toJson());
    if (response.statusCode == 200) {
      print("User registered successfully $response");
    } else {
      print("User registration failed");
    }
  } catch (error) {
    print("Error registering user: $error");
  }
}
