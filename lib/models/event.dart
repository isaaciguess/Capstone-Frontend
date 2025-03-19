import 'package:first_app/models/ticket.dart';
import 'package:first_app/models/organizer.dart';
//For Get all Events
class Events{
  final List<EventDetails> events;
  final Pagination pagination;

  Events({
    required this.events,
    required this.pagination
  });

  factory Events.fromJson(Map<String, dynamic> json){
    return Events(
      events: json["events"].map<EventDetails>((event) => EventDetails.fromJson(event)).toList(),
      pagination: Pagination.fromJson(json["pagination"])
    );
  }
} 

class EventDetails{
  final int id;
  final int organiserId;
  final String name;
  final String description;
  final String location;
  final int capacity;
  final Enum eventType;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final Enum status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Organizer organizer;
  final List<Ticket> tickets;
  final Map<String, int> registrationsCount; 

// For Get Event Details
  EventDetails({
    required this.id,
    required this.organiserId,
    required this.name,
    required this.description,
    required this.location,
    required this.capacity,
    required this.eventType,
    required this.startDateTime,
    required this.endDateTime,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.organizer,
    required this.tickets,
    required this.registrationsCount
  });

  factory EventDetails.fromJson(Map<String, dynamic> json){
    return EventDetails(
      id: json["id"],
      organiserId: json["organiserId"],
      name: json["name"],
      description: json["description"],
      location: json["location"],
      capacity: json["capacity"],
      eventType: json["eventType"],
      startDateTime: DateTime.parse(json["startDateTime"]),
      endDateTime: DateTime.parse(json["endDateTime"]),
      status: json["status"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      organizer: Organizer(
        id: json["organizer"]["id"],
        firstName: json["organizer"]["firstName"],
        lastName: json["organizer"]["lastName"]
      ),
      tickets: json["tickets"].map<Ticket>((ticket) => Ticket.fromJson(ticket)).toList(),
      registrationsCount: json["registrationsCount"]
    );
  }
}

class Pagination{
  final int total;
  final int pages;
  final int page;
  final int limit;

  Pagination({
    required this.total,
    required this.pages,
    required this.page,
    required this.limit
  });

  factory Pagination.fromJson(Map<String, dynamic> json){
    return Pagination(
      total: json["total"],
      pages: json["pages"],
      page: json["page"],
      limit: json["limit"]
    );
  }
}

// For Get Event By ID
class EventWithQuestions{
  final int id;
  final int organiserId;
  final String name;
  final String description;
  final String location;
  final int capacity;
  final Enum eventType;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final Enum status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final OrganizerName organizer;
  final List<Ticket> tickets;
  final Map<String, int> registrationsCount; 

  EventWithQuestions({
    required this.id,
    required this.organiserId,
    required this.name,
    required this.description,
    required this.location,
    required this.capacity,
    required this.eventType,
    required this.startDateTime,
    required this.endDateTime,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.organizer,
    required this.tickets,
    required this.registrationsCount
  });

  factory EventWithQuestions.fromJson(Map<String, dynamic> json){
    return EventWithQuestions(
      id: json["id"],
      organiserId: json["organiserId"],
      name: json["name"],
      description: json["description"],
      location: json["location"],
      capacity: json["capacity"],
      eventType: json["eventType"],
      startDateTime: DateTime.parse(json["startDateTime"]),
      endDateTime: DateTime.parse(json["endDateTime"]),
      status: json["status"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      organizer: OrganizerName(
        firstName: json["organizer"]["firstName"],
        lastName: json["organizer"]["lastName"]
      ),
      tickets: json["tickets"].map<Ticket>((ticket) => Ticket.fromJson(ticket)).toList(),
      registrationsCount: json["registrationsCount"]
    );
  }
}

// For Create new Event
CreateEventDTO{

}

