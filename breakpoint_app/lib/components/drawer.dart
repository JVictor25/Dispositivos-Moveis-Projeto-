import 'package:flutter/material.dart';

class myDrawer extends StatelessWidget {
  const myDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const [
          UserAccountsDrawerHeader(
            accountName: Text('Adilson'),
            accountEmail: Text('adilson@breakpoint.com'),
            currentAccountPicture: Icon(
              Icons.person,
              color: Colors.white,
              size: 40,
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xFF3A1078),
              Color(0xFF6A5ACD),
              Color(0xFF836FFF)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              size: 30,
            ),
            title: Text('Perfil',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'sans-serif')),
            //onTap: ,
          ),
          ListTile(
            leading: Icon(
              Icons.person_add,
              size: 30,
            ),
            title: Text('Amigos',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'sans-serif')),
            //onTap: ,
          ),
          ListTile(
            leading: Icon(
              Icons.flag,
              size: 30,
            ),
            title: Text('Missões',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'sans-serif')),
            //onTap: ,
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 30,
            ),
            title: Text('Configurações',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'sans-serif')),
            //onTap: ,
          ),
        ],
      ),
    );
  }
}
