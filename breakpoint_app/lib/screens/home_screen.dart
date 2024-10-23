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

class _HomescreenState extends State<Homescreen> with SingleTickerProviderStateMixin {
  
  late final TabController _tabController = TabController(length: 3, vsync: this);

  @override
  void initState(){
    super.initState();
    _tabController.addListener((){
      setState(() {
      });
    });
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
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
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
                    )),
              )),
        ),
        drawer: myDrawer(),
        body: Column(
          children: <Widget>[
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                Addiction(),
                Achievements(),
                Diary(),
              ]),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: TabBar(
                  controller: _tabController,
                  indicatorColor: const Color(0xFF3A1078),
                  labelColor: const Color(0xFF3A1078),
                  unselectedLabelColor: Color(0xFF3A1078),
                  tabs: [
                    Tab(
                      icon: Icon( _tabController.index == 0 ? Icons.home_rounded : Icons.home_outlined ),
                      text: 'Início',
                    ),
                    Tab(
                      icon: Icon( _tabController.index == 1 ? Icons.emoji_events : Icons.emoji_events_outlined),
                      text: "Conquistas",
                    ),
                    Tab(
                      icon: Icon(_tabController.index == 2 ? Icons.book : Icons.book_outlined),
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
