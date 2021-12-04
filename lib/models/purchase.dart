//@dart=2.9

import 'dart:convert';

Purchase purchaseFromJson(String str) => Purchase.fromJson(json.decode(str));

String purchaseToJson(Purchase data) => json.encode(data.toJson());

class Purchase {
  Purchase({
    this.dateTime,
    this.purchaseAmount,
    this.paymentMethodType,
    this.eventId,
    this.id,
  });

  String dateTime;
  int purchaseAmount;
  String paymentMethodType;
  int eventId;
  int id;

  factory Purchase.fromJson(Map<String, dynamic> json) {
    json = json['purchase'];
    return Purchase(
      dateTime: json["dateTime"],
      purchaseAmount: json["purchaseAmount"],
      paymentMethodType: json["paymentMethodType"],
      eventId: json["eventId"],
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "dateTime": dateTime,
        "purchaseAmount": purchaseAmount,
        "paymentMethodType": paymentMethodType,
        "eventId": eventId,
        "id": id,
      };
}
