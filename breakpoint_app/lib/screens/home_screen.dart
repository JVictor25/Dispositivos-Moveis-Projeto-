// ignore_for_file: prefer_const_constructors

import 'package:breakpoint_app/model/User.dart';
import 'package:breakpoint_app/model/Vice.dart';
import 'package:breakpoint_app/screens/achievements_screen.dart';
import 'package:breakpoint_app/screens/addiction_screen.dart';
import 'package:breakpoint_app/screens/Diary_screen.dart';
import 'package:flutter/material.dart';
import 'package:breakpoint_app/components/drawer.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({
    super.key,
    required User activeUser
    }) : _activeUser = activeUser;

  final User _activeUser;


  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _currentPageIndex = 0;
  List<Vice> _addictionList = []; 
  
  void _receiveList(List<Vice> list){
    _addictionList = list;
  }

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
              color: Color(0xff133E87)
            ),
          ),
        ),
        drawer: myDrawer(activeUser: widget._activeUser,),
        bottomNavigationBar: NavigationBar(
          indicatorColor: Colors.black,
          backgroundColor: Color(0xffDCDCDC),
          selectedIndex: _currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
          destinations: <Widget>[
            NavigationDestination(
              icon: _currentPageIndex == 0 ?
              Icon( Icons.home_rounded, color: Color(0xffA8DADC))
              : Icon( Icons.home_outlined, color:Colors.black),
              label: 'Início',
            ),
            NavigationDestination(
              icon: _currentPageIndex == 1 ?
              Icon(Icons.emoji_events, color: Color(0xffA8DADC),) 
              : Icon(Icons.emoji_events_outlined, color: Colors.black,),
              label: 'Conquistas',
            ),
            NavigationDestination(
              icon: _currentPageIndex == 2 ?
              Icon(Icons.book, color: Color(0xffA8DADC),)
              : Icon(Icons.book_outlined, color: Colors.black,),
              label: 'Diário',
            ),
          ],
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        ),
        body: _currentPageIndex == 0
            ? Addiction() // Nenhuma alteração necessária aqui
            : _currentPageIndex == 1
                ? Achievements() // Remova a passagem de `viceList`
                : Diary(),
      ),
    );
  }
}
