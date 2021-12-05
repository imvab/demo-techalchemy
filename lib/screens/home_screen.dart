// @dart=2.9

import 'package:carousel_slider/carousel_slider.dart';
import 'package:demo_app/models/event_detail.dart';
import 'package:demo_app/models/events.dart';
import 'package:demo_app/utils/colors.dart';
import 'package:demo_app/components/event_card.dart';
import 'package:demo_app/utils/utils.dart';
import 'package:flutter/material.dart';

import '../components/event_card_big.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPos = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: const Color(0xff7456cf),
          elevation: 30,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))),
          title: const Text('Welcome'),
        ),
        body: Column(
          children: [
            Container(
                color: Colors.grey[200],
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 10, left: 20),
                height: 30,
                child: const Text(
                  "Recommended Events",
                  textAlign: TextAlign.left,
                )),
            Container(
                color: Colors.grey[200],
                height: 250,
                child: FutureBuilder<Events>(
                  future: getEvents(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<AllEvent> events =
                          snapshot.data.allEvents.where((element) => element.isRecommended).toList();
                      return Column(children: [
                        CarouselSlider.builder(
                            options: CarouselOptions(
                                enableInfiniteScroll: false,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    currentPos = index;
                                  });
                                }),
                            itemCount: events.length,
                            itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                                EventCard(events[itemIndex])),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List<Widget>.generate(events.length, (index) {
                              return Container(
                                width: 8.0,
                                height: 8.0,
                                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: currentPos == index
                                      ? const Color.fromRGBO(0, 0, 0, 0.9)
                                      : const Color.fromRGBO(0, 0, 0, 0.4),
                                ),
                              );
                            })),
                      ]);
                    } else if (snapshot.hasError) {
                      return const Center(child: Text("Encountered an error", style: TextStyle(color: Colors.black)));
                    } else {
                      return const Center(child: CircularProgressIndicator(color: accentColor));
                    }
                  },
                )),
            Container(
                padding: const EdgeInsets.only(top: 20, left: 20),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: const Text(
                  "All Events",
                  textAlign: TextAlign.left,
                )),
            Expanded(
                child: FutureBuilder<EventDetails>(
                    future: getEventDetails(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data.eventDetails.length,
                            itemBuilder: (context, index) => EventCardBig(snapshot.data.eventDetails[index]));
                      } else if (snapshot.hasError) {
                        return const Center(child: Text("Encountered an error", style: TextStyle(color: Colors.black)));
                      } else {
                        return const Center(child: CircularProgressIndicator(color: accentColor));
                      }
                    }))
          ],
        ));
  }
}
