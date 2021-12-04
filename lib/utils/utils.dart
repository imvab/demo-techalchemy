// @dart=2.9

import 'dart:convert';

import 'package:demo_app/models/event_detail.dart';
import 'package:demo_app/models/events.dart';
import 'package:demo_app/models/purchase.dart';
import 'package:demo_app/utils/constants.dart';
import 'package:demo_app/utils/urls.dart';
import 'package:http/http.dart' as http;

Future<Events> getEvents() async {
  http.Response response = await http
      .get(Uri.parse(allEvents), headers: {"Authorization": "Bearer $token", "content-type": "application/json"});
  return eventsFromJson(response.body);
}

Future<EventDetails> getEventDetails() async {
  http.Response response = await http
      .get(Uri.parse(eventDetails), headers: {"Authorization": "Bearer $token", "content-type": "application/json"});
  return eventDetailsFromJson(response.body);
}

Future<EventDetail> getEventDetail(int id) async {
  String url = eventDetails;
  url += '/$id';
  http.Response response =
      await http.get(Uri.parse(url), headers: {"Authorization": "Bearer $token", "content-type": "application/json"});
  return EventDetail.fromJson(json.decode(response.body)['eventDetail']);
}

Future<Purchase> purchaseTicket(int id) async {
  http.Response response = await http.post(Uri.parse(purchase),
      body: json.encode({
        "purchase": {"dateTime": "2/13/2021 16:00:00", "purchaseAmount": 120, "paymentMethodType": "visa", "eventId": 3}
      }),
      headers: {"Authorization": "Bearer $token", "content-type": "application/json"});
  return purchaseFromJson(response.body);
}
