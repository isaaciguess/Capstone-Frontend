import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;

final Map<String, String> routes =
{
  "login":"http://localhost:3000/api/auth/login",
  "refreshToken":"http://localhost:3000/api/auth/refresh-token",
  "registerUser":"http://localhost:3000/api/auth/register-user"
};

// To Implement 
Future<void> loginUser(String email, String password) async
{
  final url = Uri.parse(routes['login'] as String);
  try 
  {

    final response = await http.post(
      url,
      headers: { 'Content-Type':'application/json'},
      body: jsonEncode({'email':email,'password':password })
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Login Success! Token: ${data}');
    }

  }
  catch(error)
  {
    print('Request failed: $error');
  }
}

Future<void> refreshToken() async{}
Future<void> registerUser() async{}

//Implemented