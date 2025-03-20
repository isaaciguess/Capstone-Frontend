import 'dart:ffi';
import 'dart:convert';
import 'dart:ffi';
import 'package:first_app/network/auth.dart';
import "package:first_app/network/dio_client.dart";
import "package:first_app/models/event.dart";
import "package:dio/dio.dart";

// TO DO  
Future<void> createEvent(CreateEventDTO event) async {
  try {
    final response = await dioClient.dio.post(
      "/events",
      data: event.toJson(),
          options: Options(
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    ));
    if (response.statusCode == 200) {
      print("Event created successfully: ${response.data}");
    } else {
      print("Failed to create event: ${response.data}");
    }
  } catch (error) {
    print("Error creating event: $error");
  }
}

Future<void> updateEvent(int id, UpdateEventDTO updatedEvent) async {
  try {
    final response = await dioClient.dio.put(
      "/events/$id",
      data: updatedEvent,
          options: Options(
      headers: {
        'Authorization': 'Bearer $accessToken',}));
    if (response.data["statis"] == "success") {
      print("Event updated successfully: ${response.data}");
    } else {
      print("Failed to update event: ${response.data}");
    }
  } catch (error) {
    print("Error updating event: $error");
  }     
}

Future<void> deleteEvent(int id) async {
  try {
    final response = await dioClient.dio.delete(
      "/events/$id",
          options: Options(
      headers:
        {'Authorization': 'Bearer $accessToken',}));
    if (response.data["status"] == "success") {
      print("Event deleted successfully: ${response.data}");
    } else {
      print("Failed to delete event: ${response.data}");
    }
  } catch (error) {
    print("Error deleting event: $error");
  }
}

//Implemented
Future<Events?> getAllEvents() async {
  try{
    final response = await dioClient.dio.get("/events");
    if(response.statusCode == 200){
      final  responseData = response.data;
      Events events = Events.fromJson(responseData["data"]);
      return events;
    }
    else{
      print("Failed to get events: ${response.data}");
    }
  }
  catch(error){
    print("Error getting events: $error");
  }
  return null;
}

Future<EventWithQuestions?> getEventById(int id) async {
   try { 

    final response = await dioClient.dio.get("/events/1");

    if (response.statusCode == 200) {
     
      final responseData = response.data;
      EventWithQuestions event = EventWithQuestions.fromJson(responseData["data"]);
    } else {
      print("Failed to get event ${response.data}");
    }
  } catch (error) {
    print("Error getting event $error");
  }
  return null;
}