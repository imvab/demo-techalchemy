//@dart=2.9

import 'dart:convert';

import 'package:jiffy/jiffy.dart';

EventDetails eventDetailsFromJson(String str) => EventDetails.fromJson(json.decode(str));

String eventDetailsToJson(EventDetails data) => json.encode(data.toJson());

class EventDetails {
  EventDetails({
    this.eventDetails,
  });

  List<EventDetail> eventDetails;

  factory EventDetails.fromJson(Map<String, dynamic> json) => EventDetails(
        eventDetails: List<EventDetail>.from(json["eventDetails"].map((x) => EventDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "eventDetails": List<dynamic>.from(eventDetails.map((x) => x.toJson())),
      };
}

class EventDetail {
  EventDetail({
    this.name,
    this.dateTime,
    this.bookBy,
    this.ticketsSold,
    this.maxTickets,
    this.friendsAttending,
    this.price,
    this.isPartnered,
    this.sport,
    this.totalPrize,
    this.location,
    this.description,
    this.venueInformation,
    this.eventCreator,
    this.teamInformation,
    this.tags,
    this.mainImage,
    this.id,
  });

  String name;
  String dateTime;
  String bookBy;
  int ticketsSold;
  int maxTickets;
  int friendsAttending;
  double price;
  bool isPartnered;
  String sport;
  int totalPrize;
  String location;
  String description;
  String venueInformation;
  String eventCreator;
  String teamInformation;
  String tags;
  String mainImage;
  int id;

  static String parseDate(String json) {
    List<int> date = json.substring(0, 9).split('/').map((e) => int.parse(e)).toList();
    List<int> time = json.substring(10).split(':').map((e) => int.parse(e)).toList();
    Jiffy jif = Jiffy(
        {"year": date[2], "month": date[1], "day": date[0], "hour": time[0], "minute": time[1], "second": time[2]});
    return jif.E + ", ${jif.day} ${jif.MMM} ${jif.year} ${jif.Hm}";
  }

  factory EventDetail.fromJson(Map<String, dynamic> json) => EventDetail(
        name: json["name"],
        dateTime: parseDate(json["dateTime"]),
        bookBy: json["bookBy"],
        ticketsSold: json["ticketsSold"],
        maxTickets: json["maxTickets"],
        friendsAttending: json["friendsAttending"],
        price: json["price"].toDouble(),
        isPartnered: json["isPartnered"],
        sport: json["sport"],
        totalPrize: json["totalPrize"],
        location: json["location"],
        description: json["description"],
        venueInformation: json["venueInformation"],
        eventCreator: json["eventCreator"],
        teamInformation: json["teamInformation"],
        tags: json["tags"],
        mainImage: json["mainImage"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "dateTime": dateTime,
        "bookBy": bookBy,
        "ticketsSold": ticketsSold,
        "maxTickets": maxTickets,
        "friendsAttending": friendsAttending,
        "price": price,
        "isPartnered": isPartnered,
        "sport": sport,
        "totalPrize": totalPrize,
        "location": location,
        "description": description,
        "venueInformation": venueInformation,
        "eventCreator": eventCreator,
        "teamInformation": teamInformation,
        "tags": tags,
        "mainImage": mainImage,
        "id": id,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
