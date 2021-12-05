//@dart=2.9

import 'dart:convert';

Events eventsFromJson(String str) => Events.fromJson(json.decode(str));

String eventsToJson(Events data) => json.encode(data.toJson());

class Events {
  Events({
    this.allEvents,
  });

  List<AllEvent> allEvents;

  factory Events.fromJson(Map<String, dynamic> json) => Events(
        allEvents: List<AllEvent>.from(json["allEvents"].map((x) => AllEvent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "allEvents": List<dynamic>.from(allEvents.map((x) => x.toJson())),
      };
}

class AllEvent {
  AllEvent({
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
    this.isRecommended,
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
  bool isRecommended;
  String mainImage;
  int id;

  factory AllEvent.fromJson(Map<String, dynamic> json) => AllEvent(
        name: json["name"],
        dateTime: json["dateTime"],
        bookBy: json["bookBy"],
        ticketsSold: json["ticketsSold"],
        maxTickets: json["maxTickets"],
        friendsAttending: json["friendsAttending"],
        price: json["price"].toDouble(),
        isPartnered: json["isPartnered"],
        sport: json["sport"],
        totalPrize: json["totalPrize"],
        location: json["location"],
        isRecommended: json["isRecommended"],
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
        "isRecommended": isRecommended,
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
