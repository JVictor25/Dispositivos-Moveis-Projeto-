// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:breakpoint_app/model/Vice.dart';
import 'package:breakpoint_app/widgets/register_user.dart';
import 'package:flutter/material.dart';
import 'package:breakpoint_app/model/User.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  bool _obscureText = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final List<User> _userList = [
    User(
      id: '0',
      username: "Admin",
      email: "Admin@breakpoint.com",
      password: "123",
    )
  ];

  void _showRegisterUser() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => Registeruser(onSubmit: _addUser)),
    );
  }

  void _addUser(String username, String email, String password) {
    User _newUser = User(
      id: '0',
      username: username,
      email: email,
      password: password,
    );

    _userList.add(_newUser);
  }

  void _removeUser(User user) {
    _userList.remove(user);
  }

  void _validateUser() {
    for (User u in _userList) {
      if (_emailController.text == u.email &&
          _passwordController.text == u.password) {
        Navigator.of(context).pushNamed('home', arguments: u);
      } else if (u == _userList.last &&
          (_emailController.text != u.email ||
              _passwordController.text != u.password)) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: Row(
                children: [
                  Icon(
                    Icons.warning_amber_outlined,
                    color: Color(0xff424242),
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Erro",
                    style: TextStyle(
                      color: Color(0xff424242),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              content: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                child: Text(
                  "Email ou senha incorretos. Tente novamente.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff424242),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              actionsAlignment: MainAxisAlignment.end,
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Color(0xff424242),
                    backgroundColor: Color(0xffA8DADC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "OK",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "PoppinsLight",
                          color: Color(0xff424242)),
                    ),
                  ),
                ),
              ],
            );
          },
        );
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
          color: Color(0xff424242),
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black87.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(3, 3),
                  )
                ]),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                              color: Color(0xff133E87),
                              ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: Icon(
                                          Icons.arrow_back_ios_new,
                                          color: Colors.white,
                                        )),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 16, 0),
                                    child: Text("Login",
                                        style: TextStyle(
                                          fontFamily: "PoppinsLight",
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 35, horizontal: 16),
                    child: Text(
                      "BreakPoint",
                      style: TextStyle(
                          fontFamily: "PoppinsBlack",
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Color(0xffA8DADC)),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: TextField(
                      controller: _emailController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xff424242),
                        border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          label: Text(
                            "Email",
                            style: TextStyle(
                                fontFamily: "PoppinsLight",
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffA8DADC)),
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Color(0xffA8DADC),
                          )),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xff424242),
                        border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          label: Text(
                            "Senha",
                            style: TextStyle(
                                fontFamily: "PoppinsLight",
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffA8DADC)),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0xffA8DADC),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Color(0xffA8DADC),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          )),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              //Ainda não foi implementado
                            },
                            child: Text(
                              "Esqueceu a senha?",
                              style: TextStyle(
                                  fontFamily: "PoppinsLight",
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffA8DADC),
                                  decoration: TextDecoration.underline,
                                  decorationColor: Color(0xffA8DADC)),
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        _validateUser();
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Color(0xffA8DADC)),
                      child: Text(
                        "Entrar",
                        style: TextStyle(
                            fontFamily: "PoppinsLight",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Não tem uma conta?",
                          style: TextStyle(
                              fontFamily: "PoppinsLight",
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        TextButton(
                            onPressed: () {
                              _showRegisterUser();
                            },
                            child: Text(
                              "Inscrever-se",
                              style: TextStyle(
                                  fontFamily: "PoppinsLight",
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffA8DADC),
                                  decoration: TextDecoration.underline,
                                  decorationColor: Color(0xffA8DADC)),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
