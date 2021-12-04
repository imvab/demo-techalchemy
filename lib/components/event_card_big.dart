// @dart=2.9

import 'package:demo_app/components/heart_button.dart';
import 'package:demo_app/models/event_detail.dart';
import 'package:demo_app/screens/event_details.dart';
import 'package:demo_app/utils/colors.dart';
import 'package:demo_app/utils/custom_icons.dart';
import 'package:flutter/material.dart';

class EventCardBig extends StatefulWidget {
  final EventDetail event;
  const EventCardBig(this.event, {Key key}) : super(key: key);

  @override
  _EventCardBigState createState() => _EventCardBigState();
}

class _EventCardBigState extends State<EventCardBig> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(30),
        child: InkWell(
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetailsScreen(
                          widget.event.name, widget.event.mainImage, widget.event.price, widget.event.id,
                          eventDetail: widget.event),
                    ),
                  );
                },
                child: Material(
                    borderRadius: BorderRadius.circular(30),
                    elevation: 30,
                    child: Container(
                      height: 420,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        children: [
                          Stack(children: [
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                                image: DecorationImage(
                                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
                                  fit: BoxFit.cover,
                                  image: NetworkImage(widget.event.mainImage),
                                ),
                              ),
                            ),
                            Container(
                              height: 200,
                              padding: const EdgeInsets.only(left: 20, top: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(children: [
                                    if (widget.event.isPartnered)
                                      Container(
                                        child: const Center(
                                            child: Text(
                                          "Partnered",
                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                        )),
                                        width: 80,
                                        height: 20,
                                        decoration: const BoxDecoration(
                                            color: Colors.cyanAccent,
                                            borderRadius: BorderRadius.all(Radius.circular(20))),
                                      ),
                                    if (widget.event.isPartnered) const SizedBox(width: 10),
                                    Container(
                                      child: Center(
                                          child: Center(
                                              child: Text(
                                        widget.event.sport,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                      ))),
                                      width: 80,
                                      height: 20,
                                      decoration: const BoxDecoration(
                                          color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
                                    ),
                                  ]),
                                  const SizedBox(height: 10),
                                  Text(widget.event.name,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                    const Icon(
                                      CustomIcons.access_time,
                                      color: Colors.white,
                                    ),
                                    Text(widget.event.dateTime,
                                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                    Container(
                                      child: Center(
                                          child: Center(
                                              child: Text(
                                        "€ " + widget.event.price.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
                                      ))),
                                      width: 80,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                          color: Colors.cyanAccent,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))),
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                          ]),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            height: 220,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Prize: € " + widget.event.totalPrize.toString(),
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    SizedBox(width: 40, child: HeartButton(onTap: () {}))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(CustomIcons.profile),
                                    const SizedBox(width: 20),
                                    RichText(
                                        text: TextSpan(children: [
                                      const TextSpan(text: "Event Creator: ", style: TextStyle(color: accentColor)),
                                      TextSpan(
                                          text: widget.event.eventCreator,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ))
                                    ])),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(CustomIcons.ticket),
                                    const SizedBox(width: 20),
                                    Text(
                                        widget.event.ticketsSold.toString() +
                                            "/" +
                                            widget.event.maxTickets.toString() +
                                            " attending",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: accentColor,
                                          decoration: TextDecoration.underline,
                                        ))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.location_on),
                                    const SizedBox(width: 20),
                                    Flexible(
                                        child: Text(widget.event.location,
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)))
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )))));
  }
}
