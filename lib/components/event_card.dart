// @dart=2.9

import 'dart:ui';

import 'package:demo_app/models/events.dart';
import 'package:demo_app/utils/custom_icons.dart';
import 'package:demo_app/screens/event_details.dart';
import 'package:demo_app/utils/utils.dart';
import 'package:flutter/material.dart';

class EventCard extends StatefulWidget {
  final AllEvent event;
  const EventCard(this.event, {Key key}) : super(key: key);

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        child: InkWell(
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetailsScreen(widget.event.name, widget.event.mainImage,
                          widget.event.price, widget.event.id, widget.event.dateTime,
                          event: widget.event),
                    ),
                  );
                },
                child: Material(
                    borderRadius: BorderRadius.circular(30),
                    child: Stack(children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
                            image: NetworkImage(widget.event.mainImage),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            const SizedBox(width: 10),
                            const Icon(
                              CustomIcons.access_time,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 10),
                            Text(parseDate(widget.event.dateTime),
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
                          ]),
                          Container(
                              height: 50,
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              child: Text(widget.event.name,
                                  style:
                                      const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Material(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side: const BorderSide(width: 1, color: Colors.white)),
                                  child: Container(
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                      const Icon(CustomIcons.ticket, size: 14, color: Colors.white),
                                      Text(
                                        widget.event.ticketsSold.toString() + "/" + widget.event.maxTickets.toString(),
                                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                      )
                                    ]),
                                    width: 70,
                                    height: 30,
                                    decoration: const BoxDecoration(
                                        color: Colors.black, borderRadius: BorderRadius.all(Radius.circular(20))),
                                  )),
                              Material(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side: const BorderSide(width: 1, color: Colors.white)),
                                  child: Container(
                                    child: Center(
                                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                      SizedBox(height: 20, width: 20, child: Image.asset("assets/img_avatar.png")),
                                      Text(
                                        "+${widget.event.friendsAttending} friends",
                                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                      )
                                    ])),
                                    width: 110,
                                    height: 30,
                                    decoration: const BoxDecoration(
                                        color: Colors.black, borderRadius: BorderRadius.all(Radius.circular(20))),
                                  )),
                              Container(
                                child: Center(
                                    child: Text(
                                  "€ " + widget.event.price.toString(),
                                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                )),
                                width: 60,
                                height: 30,
                                decoration: const BoxDecoration(
                                    color: Colors.cyanAccent, borderRadius: BorderRadius.all(Radius.circular(20))),
                              ),
                            ],
                          ),
                        ],
                      )
                    ])))));
  }
}
