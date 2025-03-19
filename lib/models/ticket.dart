class Ticket{
  final int id;
  final int eventId;
  final String name;
  final String description;
  final double price;
  final int quantityTotal;
  final int quantitySold;
  final DateTime salesStart;
  final DateTime salesEnd;
  final Enum status;
  final DateTime createdAt;
  final DateTime updatedAt;

Ticket({
  required this.id,
  required this.eventId,
  required this.name,
  required this.description,
  required this.price,
  required this.quantityTotal,
  required this.quantitySold,
  required this.salesStart,
  required this.salesEnd,
  required this.status,
  required this.createdAt,
  required this.updatedAt
});

factory Ticket.fromJson(Map<String, dynamic> json){
  return Ticket(
    id: json["id"],
    eventId: json["eventId"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    quantityTotal: json["quantityTotal"],
    quantitySold: json["quantitySold"],
    salesStart: DateTime.parse(json["salesStart"]),
    salesEnd: DateTime.parse(json["salesEnd"]),
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"])
  );
}
}