// @dart=2.9

import 'package:demo_app/utils/constants.dart';
import 'package:demo_app/utils/custom_icons.dart';
import 'package:demo_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key key}) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> with WidgetsBindingObserver {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const HomeScreen(),
        bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: index,
                onTap: (index) {
                  setState(() {
                    index = index;
                  });
                },
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(CustomIcons.home, color: Color(0xff7456cf), size: kIconSize), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(CustomIcons.ticket, color: Color(0xff7456cf), size: kIconSize), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(CustomIcons.controller, color: Color(0xff7456cf), size: kIconSize), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(CustomIcons.profile, color: Color(0xff7456cf), size: kIconSize), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(CustomIcons.settings, color: Color(0xff7456cf), size: kIconSize), label: "Home")
                ],
              ),
            )));
  }
}
