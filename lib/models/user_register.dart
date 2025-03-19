class User {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String? phoneNo;
  final String role;

  User(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      this.phoneNo,
      this.role = "PARTICIPANT"});

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "firstName": firstName,
      "lastName": lastName,
      if (phoneNo == null) "phoneNo": " " else "phoneNo": phoneNo
    };
  }
}
