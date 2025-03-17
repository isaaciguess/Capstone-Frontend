import 'package:first_app/network/auth.dart';
import 'dart:async';
import 'package:first_app/network/dio_client.dart';

Future<void> testLogin() async {await loginUser("isaac1@gmail.com", "Isaac123");}


void main() async{
  //await testLogin();
  await testLogin();
}