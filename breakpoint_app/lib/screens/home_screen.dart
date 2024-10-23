import 'package:breakpoint_app/screens/achievements_screen.dart';
import 'package:breakpoint_app/screens/addiction_screen.dart';
import 'package:breakpoint_app/screens/diary_screen.dart';
import 'package:flutter/material.dart';
import 'package:breakpoint_app/components/drawer.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int currentPageIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3A1078), Color(0xFF836FFF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Lembre seus motivos ",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ))),
      ),
      drawer: myDrawer(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations:  const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.emoji_events),
            label: 'Conquistas',
          ),
          NavigationDestination(
            icon:  Icon(Icons.menu_book),
            label: 'Diário',
          ),
        ],
      ),
      body: <Widget>[
        Addiction(),
        Achievements(),
        Diary(),
      ][currentPageIndex],
    );
  }
}
