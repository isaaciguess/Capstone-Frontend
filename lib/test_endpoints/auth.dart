import 'package:first_app/endpoints/auth.dart';

Future<void> testLogin() async {await loginUser("isaac1@gmail.com", "Isaac123");}

void main() async{
  await testLogin();
}