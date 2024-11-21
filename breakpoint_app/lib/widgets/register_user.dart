// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class Registeruser extends StatefulWidget {
  final void Function(String, String, String, String) onSubmit;

  const Registeruser({super.key, required this.onSubmit});

  @override
  State<Registeruser> createState() => _RegisteruserState();
}

class _RegisteruserState extends State<Registeruser> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  bool _obscureText = true;
  String? _imagePath;

  void _submitUser() {
    String _username = _usernameController.text;
    String _email = _emailController.text;
    String _password = _passwordController.text;

    if (_username.isEmpty ||
        _email.isEmpty ||
        _password.isEmpty ||
        _imagePath == null) {
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
                "Preencha todos os campos e tente cadastrar-se novamente.",
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
    else{
      widget.onSubmit(_imagePath!, _username, _email, _password);
      Navigator.of(context).pop();
    }

  }

  void _showImageSelection(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: double.infinity,
            color: Color(0xffA8DADC),
            padding: EdgeInsets.all(16),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
                child: Icon(
                  Icons.image_outlined,
                  size: 50,
                  color: Color(0xff424242),
                )),
          );
        });
  }

  Future<void> _pickImage(ImageSource gallery) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imagePath = image.path;
      });
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
                mainAxisAlignment: MainAxisAlignment.center,
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
                              color: Color(0xff133E87)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 16, 0),
                                      child: Text(
                                        "Sign Up",
                                        style: TextStyle(
                                            fontFamily: "PoppinsLight",
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 30, 16, 10),
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffA8DADC),
                      ),
                      child: _imagePath != null
                          ? GestureDetector(
                              onTap: () {
                                _showImageSelection(context);
                              },
                              child: ClipOval(
                                child: Image.file(
                                  File(_imagePath!),
                                  fit: BoxFit.fill,
                                ),
                              ))
                          : GestureDetector(
                              onTap: () {
                                _showImageSelection(context);
                              },
                              child: Icon(
                                Icons.add_a_photo_outlined,
                                size: 60,
                                color: Colors.black87,
                              )),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    child: TextField(
                      controller: _usernameController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xff424242),
                        border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                        label: Text("Nome",
                            style: TextStyle(
                                fontFamily: "PoppinsLight",
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffA8DADC))),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xffA8DADC),
                        ),
                      ),
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
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
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
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        _submitUser();
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Color(0xffA8DADC)),
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(
                            fontFamily: "PoppinsLight",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Já tem uma conta?",
                        style: TextStyle(
                            fontFamily: "PoppinsLight",
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Acesse aqui",
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
