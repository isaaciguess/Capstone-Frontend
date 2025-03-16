import '../models/participant.dart';

List<Participant> getParticipantData() {
  return [
    Participant(
      id: 'P001',
      name: 'Marco Rossi',
      email: 'marco.rossi@example.com',
      phone: '+61 412 345 678',
      ticketType: 'VIP',
      registrationDate: DateTime(2024, 9, 15),
      checkedIn: true,
    ),
    Participant(
      id: 'P002',
      name: 'Giulia Bianchi',
      email: 'giulia.b@example.com',
      phone: '+61 423 456 789',
      ticketType: 'Standard',
      registrationDate: DateTime(2024, 9, 16),
      checkedIn: false,
    ),
    Participant(
      id: 'P003',
      name: 'Alessandro Verdi',
      email: 'a.verdi@example.com',
      phone: '+61 434 567 890',
      ticketType: 'Family',
      registrationDate: DateTime(2024, 9, 17),
      checkedIn: true,
    ),
    Participant(
      id: 'P004',
      name: 'Sofia Romano',
      email: 'sofia.r@example.com',
      phone: '+61 445 678 901',
      ticketType: 'VIP',
      registrationDate: DateTime(2024, 9, 18),
      checkedIn: true,
    ),
    Participant(
      id: 'P005',
      name: 'Luca Ferrari',
      email: 'luca.f@example.com',
      phone: '+61 456 789 012',
      ticketType: 'Standard',
      registrationDate: DateTime(2024, 9, 20),
      checkedIn: false,
    ),
  ];
}