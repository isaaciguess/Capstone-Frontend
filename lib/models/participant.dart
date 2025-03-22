class Participant {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String ticketType;
  final DateTime registrationDate;
  final bool checkedIn;

  Participant({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.ticketType,
    required this.registrationDate,
    required this.checkedIn,
  });
}