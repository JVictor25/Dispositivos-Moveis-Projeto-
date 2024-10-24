import 'package:breakpoint_app/screens/achievements_screen.dart';
import 'package:breakpoint_app/screens/addiction_screen.dart';
import 'package:breakpoint_app/screens/diary_screen.dart';
import 'package:flutter/material.dart';
import 'package:breakpoint_app/components/drawer.dart';
import 'package:breakpoint_app/model/Vice.dart';
import 'package:breakpoint_app/widgets/todoForm.dart';
import 'package:breakpoint_app/widgets/todoList.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen>{
  int _currentPageIndex = 0;

  List<Vice> _listaVices = [
  ];

  void _addVice(
      String typeofvice,
      DateTime dateSelect,) {
    Vice _newVice = Vice(
      typeofvice: typeofvice,
      datesobriety: dateSelect,
    );
    setState(() {
      _listaVices.add(_newVice);
    });
  }

  void _openTaskForm() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: TodoForm(onSubmit: _addVice, isModifying: false,),
      );
    },
  );
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
       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _openTaskForm,
        child: Icon(Icons.add),
      ),
      body: _currentPageIndex == 0
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(child: TodoList(listaVices: _listaVices)),
              ],
            ),
          )
        : _currentPageIndex == 1
          ? Achievements()
          : Diary(),
    ),
    );
  }
}