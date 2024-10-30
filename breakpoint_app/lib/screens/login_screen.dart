// ignore_for_file: prefer_const_constructors

import 'package:breakpoint_app/widgets/register_user.dart';
import 'package:flutter/material.dart';
import 'package:breakpoint_app/model/User.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  bool _isChecked = false;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final List<User> _userList = [
    User(
        avatar: "assets/images/avatar3.png",
        username: "Admin",
        password: "123",
        birth: DateTime(23, 12, 2001))
  ];

  void _showRegisterUser() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => Registeruser(onSubmit: _addUser)),
    );
  }

  void _addUser(
      String avatar, String username, String password, DateTime nascimento) {
    User _newUser = User(
      avatar: avatar,
      username: username,
      password: password,
      birth: nascimento,
    );
    _userList.add(_newUser);
  }

  void _removeUser(User user) {
    _userList.remove(user);
  }

  void _validateUser() {
    for (User u in _userList) {
      if (_usernameController.text == u.username &&
          _passwordController.text == u.password) {
        Navigator.of(context).pushNamed('home', arguments: u);
      } else {
        showDialog(
            context: context,
            builder: (BuilderContext) {
              return AlertDialog(
                title: Text(
                  "Erro!!",
                ),
                content: Text(
                  "Usuário ou Senha incorreto!",
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Tentar novamente",
                      ))
                ],
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff133E87),
                Color(0xFF608BC1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Entrar",
                    style: TextStyle(
                      fontFamily: 'PoppinsBlack',
                      fontSize: 30,
                      color: Color(0xffF3F3E0),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    child: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          label: Text(
                            "Usuário",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color(0xff133E87),
                          )),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        label: Text(
                          "Senha",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color(0xff133E87),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              fillColor: MaterialStateProperty.resolveWith(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Color(0xff133E87);
                                }
                                return Colors.white;
                              }),
                              value: _isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked = value!;
                                });
                              },
                            ),
                            Text(
                              "Lembre-me",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  //Ainda não foi implementado
                                },
                                child: Text("Esqueceu a senha?",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                            decoration: TextDecoration.underline,
                                            decorationColor: Colors.white))),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _validateUser();
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 40),
                        backgroundColor: Color(0xff133E87)),
                    child: Text(
                      "Acessar",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Não tem uma conta?",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      TextButton(
                          onPressed: () {
                            _showRegisterUser();
                          },
                          child: Text(
                            "Increver-se",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
