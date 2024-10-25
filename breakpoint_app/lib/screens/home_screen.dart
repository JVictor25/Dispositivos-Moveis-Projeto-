import 'package:breakpoint_app/screens/achievements_screen.dart';
import 'package:breakpoint_app/screens/addiction_screen.dart';
import 'package:breakpoint_app/screens/diary_screen.dart';
import 'package:flutter/material.dart';
import 'package:breakpoint_app/components/drawer.dart';
import 'package:breakpoint_app/model/Vice.dart';
import 'package:breakpoint_app/widgets/vice_form.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen>{
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF3A1078),
                  Color(0xFF6A5ACD),
                  Color(0xFF836FFF)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
      drawer: myDrawer(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        destinations:  <Widget>[
          NavigationDestination(
            icon: Icon( _currentPageIndex == 0 ? Icons.home_rounded : Icons.home_outlined ),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(_currentPageIndex == 1 ? Icons.emoji_events : Icons.emoji_events_outlined),
            label: 'Conquistas',
          ),
          NavigationDestination(
            icon: Icon(_currentPageIndex == 2 ? Icons.book : Icons.book_outlined),
            label: 'Diário',
          ),
        ],
      ),
      body: _currentPageIndex == 0
        ? Addiction()
        : _currentPageIndex == 1
          ? Achievements()
          : Diary(),
    ),
    );
  }
}