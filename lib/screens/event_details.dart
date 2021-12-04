//@dart=2.9

import 'package:demo_app/components/confirm_button.dart';
import 'package:demo_app/components/heart_button.dart';
import 'package:demo_app/models/event_detail.dart';
import 'package:demo_app/models/events.dart';
import 'package:demo_app/models/purchase.dart';
import 'package:demo_app/utils/colors.dart';
import 'package:demo_app/utils/custom_icons.dart';
import 'package:demo_app/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

enum ButtonState { init, loading, done }

class EventDetailsScreen extends StatefulWidget {
  final EventDetail eventDetail;
  final AllEvent event;
  final String eventName;
  final String imageUrl;
  final double price;
  final int id;
  const EventDetailsScreen(this.eventName, this.imageUrl, this.price, this.id, {this.eventDetail, this.event, Key key})
      : super(key: key);

  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  ButtonState state = ButtonState.init;
  ConfirmButtonController controller = ConfirmButtonController();
  // bool isAnimating = false;

  void showConfirmationSheet(int id, BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        context: context,
        builder: (context) => SizedBox(
            height: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ListTile(
                  title: Text("Payment Success", style: TextStyle(fontSize: 18, color: Colors.grey[600])),
                  trailing: IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(ctx);
                    },
                  ),
                ),
                SizedBox(child: Image.asset("assets/check.png"), width: 100, height: 100),
                const Text("Thank You!", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                Text("Your payment was made successfully", style: TextStyle(fontSize: 18, color: Colors.grey[600])),
                const Divider(height: 2),
                Text("Your booking ID", style: TextStyle(fontSize: 18, color: Colors.grey[600])),
                Text("#$id", style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.cyan)),
                const Divider(height: 2),
                Text(
                  "You will need this booking ID to enter inside the event. You can view this code inside your profile / booked events",
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 23),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: accentColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(ctx);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Center(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 13, 0, 13),
                              child: Text(
                                "CLOSE",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )));
  }

  Widget eventChild(EventDetail event) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 20),
      ListTile(
          dense: true,
          title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Total Prize: " + event.totalPrize.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Material(
                color: Colors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), side: const BorderSide(width: 2, color: Colors.grey)),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: const [
                  SizedBox(width: 10),
                  Icon(Icons.add, color: Colors.white),
                  SizedBox(
                    child: Center(
                        child: Text(
                      "Share Event",
                      style: TextStyle(color: Colors.white),
                    )),
                    width: 110,
                    height: 30,
                  )
                ])),
            SizedBox(width: 40, child: HeartButton(onTap: () {}))
          ])),
      ListTile(
          dense: true,
          leading: const Icon(CustomIcons.ticket),
          title: Text(event.ticketsSold.toString() + "/" + event.maxTickets.toString() + " attending",
              style: const TextStyle(
                fontSize: 16,
                color: accentColor,
                decoration: TextDecoration.underline,
              ))),
      const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Text("ABOUT:  ", style: TextStyle(wordSpacing: 4))),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Text(event.description, style: const TextStyle(wordSpacing: 4))),
      const Divider(height: 2),
      const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Text("LOCATION:  ", style: TextStyle(wordSpacing: 4))),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Row(children: [
            const Icon(Icons.location_on),
            const SizedBox(width: 10),
            Flexible(child: Text(event.location, style: const TextStyle(wordSpacing: 4))),
            const SizedBox(width: 20),
            GestureDetector(
              child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), side: const BorderSide(width: 2, color: accentColor)),
                  child: const SizedBox(
                    child: Center(
                        child: Text(
                      "Take me there",
                      style: TextStyle(color: accentColor),
                    )),
                    width: 120,
                    height: 40,
                  )),
              onTap: () async {
                String googleUrl = 'https://www.google.com/maps/search/?api=1&query=${event.location}';
                if (await canLaunch(googleUrl)) {
                  await launch(googleUrl);
                } else {
                  throw 'Could not launch $googleUrl';
                }
              },
            )
          ])),
      const Divider(height: 2),
      const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Text("CONTACT:  ", style: TextStyle(wordSpacing: 4))),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: RichText(
              text: TextSpan(children: [
            const TextSpan(text: "Send us an email at \n", style: TextStyle(color: Colors.black)),
            TextSpan(
                text: "contact@techalchemy.co",
                style: const TextStyle(color: accentColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    String uri =
                        'mailto:contact@techalchemy.co?subject=Query Regarding ${widget.event.name}&body=Hi\nWanted to ask a query regarding ${widget.event.name}';
                    if (await canLaunch(uri)) {
                      await launch(uri);
                    } else {
                      throw 'Could not launch $uri';
                    }
                  }),
            const TextSpan(text: " or call us at ", style: TextStyle(color: Colors.black)),
            const TextSpan(text: "+1 991-681-0200", style: TextStyle(color: Colors.black))
          ]))),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    bool isDone = state == ButtonState.done;

    return Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: true,
        body: CustomScrollView(
          slivers: <Widget>[
            //2
            SliverAppBar(
              backgroundColor: Colors.black,
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: 250.0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(widget.eventName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                background: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.imageUrl),
                    ),
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
                child: widget.eventDetail == null
                    ? FutureBuilder<EventDetail>(
                        future: getEventDetail(widget.event.id),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return eventChild(snapshot.data);
                          } else {
                            return const Center(child: CircularProgressIndicator(color: accentColor));
                          }
                        })
                    : eventChild(widget.eventDetail))
          ],
        ),
        bottomSheet: Material(
            elevation: 60,
            child: SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: RoundedLoadingButton(
                  color: const Color(0xff11d0a2),
                  controller: controller,
                  child: Text(
                    "€ ${widget.price} - I'M IN!",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: isDone
                      ? () {}
                      : () async {
                          Purchase purchase = await purchaseTicket(widget.id);
                          controller.success();
                          await Future.delayed(const Duration(seconds: 2));
                          showConfirmationSheet(purchase.id, context);
                        },
                ))));
  }
}
