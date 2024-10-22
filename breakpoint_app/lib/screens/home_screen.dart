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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
        body: Column(
          children: <Widget>[
            const Expanded(
              child: TabBarView(children: [
                Addiction(),
                Achievements(),
                Diary(),
              ]),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [ Color(0xFF836FFF), Color(0xFF3A1078)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: const TabBar(
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: [
                Tab(
                  icon: Icon(Icons.home),
                  text: 'Início',
                ),
                Tab(
                  icon: Icon(Icons.emoji_events),
                  text: "Conquistas",
                ),
                Tab(
                  icon: Icon(Icons.menu_book),
                  text: "Diário",
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
