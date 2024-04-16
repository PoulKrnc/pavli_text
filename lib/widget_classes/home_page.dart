// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, avoid_print, avoid_unnecessary_containers, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pavli_text/widget_classes/game_page.dart';
import 'contacts_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  final Map<String, dynamic> data;
  final Map<String, dynamic> setupsList;
  final int index;
  const HomePage(
      {Key? key,
      required this.data,
      required this.setupsList,
      required this.index})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  var db = FirebaseFirestore.instance;
  var data1;
  PageController _pageController = PageController(initialPage: 1);

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    setState(() {
      _selectedIndex = widget.index;
      _pageController = PageController(initialPage: widget.index);
    });
  }

  String str1 = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _pageController, // PageController instance
          onPageChanged: _onPageChanged, // Function to handle page change
          children: <Widget>[
            GamePage(
              data: widget.data,
              setupsList: widget.setupsList,
            ),
            ContactsPage(
              data: widget.data,
              setupsList: widget.setupsList,
            ),
            ProfilePage(
              data: widget.data,
              setupsList: widget.setupsList,
            )
          ],
        ),
        bottomNavigationBar: _bottomNavigationBar());
  }

  ClipRRect _bottomNavigationBar() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.gamepad), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
        backgroundColor: Colors.blue,
        unselectedFontSize: 0,
        selectedFontSize: 1,
        unselectedIconTheme: const IconThemeData(
          size: 24,
        ),
        selectedIconTheme: const IconThemeData(size: 30, shadows: <Shadow>[
          Shadow(offset: Offset(3, 3), blurRadius: 1.5, color: Colors.black54)
        ]),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget page() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                "HOME",
                style: TextStyle(fontSize: 23),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
