// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:breakpoint_app/model/User.dart';
import 'package:breakpoint_app/providers/active_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class myDrawer extends StatefulWidget {
  const myDrawer({super.key,});

  @override
  State<myDrawer> createState() => _myDrawerState();
}

class _myDrawerState extends State<myDrawer> {
  void _exit() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sair'),
          content: Text('Deseja fechar o aplicativo?'),
          actions: [
            TextButton(
              child: Text('Sim'),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
            TextButton(
              child: Text('Não'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ActiveUser>(context).currentUser as User;
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff133E87),
        ),
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      user.username,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.star_border,
                  size: 30,
                  color: Colors.white,
                ),
                title: Text(
                  'Premium',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                //onTap: ,
              ),
              ListTile(
                leading: Icon(
                  Icons.person_2_outlined,
                  size: 30,
                  color: Colors.white,
                ),
                title: Text(
                  'Perfil',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                //onTap: ,
              ),
              ListTile(
                leading: Icon(
                  Icons.person_add_alt,
                  size: 30,
                  color: Colors.white,
                ),
                title: Text(
                  'Amigos',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                //onTap: ,
              ),
              ListTile(
                leading: Icon(
                  Icons.flag_outlined,
                  size: 30,
                  color: Colors.white,
                ),
                title: Text(
                  'Missões',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                //onTap: ,
              ),
              ListTile(
                leading: Icon(
                  Icons.settings_outlined,
                  size: 30,
                  color: Colors.white,
                ),
                title: Text(
                  'Configurações',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                //onTap: ,
              ),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app_outlined,
                  size: 30,
                  color: Colors.white,
                ),
                title: Text(
                  'Sair',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                onTap: _exit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
