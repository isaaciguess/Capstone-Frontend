import 'dart:ffi';


// To do 
Future<void> getUserProfile(String id) async {}
Future<void> updateUserProfile(String id, Struct newProfile) async {}
Future<void> changePassword(String id, Struct passwordUpdate) async {}


// ADMIN role endpoints
Future<void> createUser(Struct user) async {}
Future<void> getAllUsers() async {}
Future<void> getUserById(String id) async {}
Future<void> updateUserRole(String id) async {}
Future<void> deleteUser(String id) async {}

// Implementation