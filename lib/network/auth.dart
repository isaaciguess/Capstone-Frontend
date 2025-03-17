import 'dart:convert';
import 'dart:ffi';
import "package:first_app/network/dio_client.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:first_app/models/user.dart";


String? accessToken;

//Implemented
Future<void> loginUser(String email, String password) async {
  try {
    final response = await dioClient.dio.post("/auth/login",
      data: {"email": "isaac1@gmail.com", "password": "Isaac123"},
    );

    if (response.statusCode == 200)
    {
      final Map<String, dynamic> responseData = response.data;

      final String accessToken = responseData["data"]?["accessToken"];

      //await storage.write(key: "accessToken", value: accessToken); TO DO IMPLEMENT SECURE STORAGE
  
      handleAccessToken(accessToken);
    }
    else
    {
      print("Login failed: ${response.data}");
    }
  }
  catch (error) {
    print("Login error: $error");
  }
}

void handleAccessToken(String? accessToken) async
{
  if (accessToken != null) {
    //await storage.write(key: "accessToken", value: accessToken); TO DO IMPLEMENT SECURE STORAGE
    accessToken = accessToken;
    print("Login successful! Access Token stored.");
  } 
  else
  {
    print("Error: Access Token not found in response.");
  }
}

Future<void> refreshToken() async{
  try
  {
    final response = await dioClient.dio.post("/auth/refresh-token");
    response.statusCode == 200 ? print("Token refresh successful") : print("Token refresh failed: ${response.data}");
  } catch (error){
    print("Error refreshing token: $error");
  }
}


// TO DO ADD PROPER SUCESSFUL RESPONSE HANDLING
Future<void> registerUser(User data) async{
  try {
    final response = await dioClient.dio.post("/auth/register", data: data.toJson());
    if (response.statusCode == 200) {
      print("User registered successfully!");
    } else {
      print("User registration failed");
    }
  } catch (error) {
    print("Error registering user: $error");
  }
}

