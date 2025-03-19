import 'dart:ffi';
import 'dart:convert';
import 'dart:ffi';
import "package:first_app/network/dio_client.dart";
import "package:first_app/models/event.dart";
//To Implement / WIP
Future<void> getAllEvents() async{
  try{
    final response = await dioClient.dio.get("/events");
    if(response.statusCode == 200){
      final  responseData = response.data;
      print("Events: $responseData");
    }
    else{
      print("Failed to get events: ${response.data}");
    }
  }
  catch(error){
    print("Error getting events: $error");
  }
}
Future<void> getEventById(int id) async{
  try
  { final response = await dioClient.dio.get("/events/1");
    if(response.statusCode == 200){
      final responseData = response.data;
      print("Event: $responseData");
    }
    else {
      print("Failed to get event ${response.data}");
    }
  }
  catch(error){
    print("Error getting event $error");
  }
}
Future<void> createEvent(Struct event) async {
  
}
Future<void> updateEvent(int id, Struct updatedEvent) async{}
Future<void> deleteEvent(int id) async{}

//Implemented