// @dart=2.9

import 'dart:convert';

import 'package:demo_app/models/event_detail.dart';
import 'package:demo_app/models/events.dart';
import 'package:demo_app/models/purchase.dart';
import 'package:demo_app/utils/constants.dart';
import 'package:demo_app/utils/urls.dart';
import 'package:http/http.dart' as http;

Future<Events> getEvents() async {
  http.Response response = await http.get(Uri.parse(allEvents),
      headers: {"Authorization": "Bearer $token", "content-type": "application/json"}).catchError((e) => throw e);
  return eventsFromJson(response.body);
}

Future<EventDetails> getEventDetails() async {
  http.Response response = await http.get(Uri.parse(eventDetails),
      headers: {"Authorization": "Bearer $token", "content-type": "application/json"}).catchError((e) => throw e);
  return eventDetailsFromJson(response.body);
}

Future<EventDetail> getEventDetail(int id) async {
  String url = eventDetails;
  url += '/$id';
  http.Response response = await http.get(Uri.parse(url),
      headers: {"Authorization": "Bearer $token", "content-type": "application/json"}).catchError((e) => throw e);
  return EventDetail.fromJson(json.decode(response.body)['eventDetail']);
}

Future<Purchase> purchaseTicket(double amount, int id) async {
  http.Response response = await http.post(Uri.parse(purchase),
      body: json.encode({
        "purchase": {"dateTime": DateTime.now(), "purchaseAmount": amount, "paymentMethodType": "visa", "eventId": id}
      }),
      headers: {"Authorization": "Bearer $token", "content-type": "application/json"}).catchError((e) => throw e);
  return purchaseFromJson(response.body);
}
