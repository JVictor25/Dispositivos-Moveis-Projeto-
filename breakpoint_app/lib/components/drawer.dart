// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:breakpoint_app/model/User.dart';
import 'package:breakpoint_app/providers/active_user.dart';
import 'package:breakpoint_app/providers/user_service.dart';
import 'package:breakpoint_app/screens/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class myDrawer extends StatefulWidget {
  const myDrawer({
    super.key,
  });

  @override
  State<myDrawer> createState() => _myDrawerState();
}

class _myDrawerState extends State<myDrawer> {
  String? _username;
  String? _email;
  DateTime _createdAt = DateTime.now();
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_username == null && _email == null) {
      _getUser(context);
    }
  }

  void _getUser(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final token =
          Provider.of<ActiveUser>(context, listen: false).currentUser as String;
      final response = await Provider.of<UserService>(context, listen: false)
          .fetchUser(token);

      setState(() {
        _username = response['name'];
        _email = response['email'];
        _createdAt = DateTime.parse(response['createdAt']);
        _isLoading = false;
      });
    } catch (error) {
      debugPrint('Error fetching user: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Bem-vindo(a)!',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  // Nome de usuário
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _username ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  // E-mail
                  Row(
                    children: [
                      Text(
                        _email ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
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
                onTap: () {
                  Navigator.of(context)
                      .push<String>(
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(
                        username: _username,
                        email: _email,
                        token: Provider.of<ActiveUser>(context, listen: false)
                            .currentUser as String,
                      ),
                    ),
                  )
                      .then((value) {
                    if (value != null) {
                      Navigator.of(context).pop();
                      Provider.of<UserService>(context, listen: false)
                          .fetchUser(
                        Provider.of<ActiveUser>(context, listen: false)
                            .currentUser as String,
                      );
                    }
                  });
                },
              ),
              /*ListTile(
                leading: Icon(
                  Icons.person_add_alt,
                  size: 30,
                  color: Colors.white,
                ),
                title: Text(
                  'Amigos',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),*/
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
}
