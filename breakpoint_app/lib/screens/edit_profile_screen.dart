// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors

import 'package:breakpoint_app/data/data.dart';
import 'package:breakpoint_app/providers/vice_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:breakpoint_app/providers/user_service.dart';

class EditProfileScreen extends StatefulWidget {
  final String? username;
  final String? email;
  final String? token;

  const EditProfileScreen({
    Key? key,
    this.username,
    this.email,
    this.token,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _obscureText = true;

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  void _submitEdit() async {
    final isValid = _formKey.currentState?.validate() ??
        true;

    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();

    await Provider.of<UserService>(context, listen: false)
        .updateUser(_formData, widget.token!)
        .then((onValue) {
      Navigator.pop(context);
    }).catchError((error) {
      print('Erro ao atualizar usuário: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff133E87),
        title: Text(
          'Detalhes do Perfil',
          style: TextStyle(
              fontFamily: "PoppinsRegular",
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Color(0xff133E87),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    Provider.of<ViceProvider>(context, listen: false)
                        .getAvatar(),
                    style: TextStyle(
                      fontFamily: "PoppinsBold",
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(
                      imageMap[Provider.of<ViceProvider>(context).getAvatar()] ??
                          'assets/images/default.png',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.username ?? 'Usuário',
                    style: TextStyle(
                      fontFamily: "PoppinsBold",
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.email ?? 'Email não fornecido',
                      style: TextStyle(
                        fontFamily: "PoppinsRegular",
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Editar Nome",
                      style: TextStyle(
                        fontFamily: "PoppinsBold",
                        fontSize: 18,
                        color: Color(0xff133E87),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      initialValue:
                          _formData['name']?.toString() ?? '', // Valor padrão
                      style: TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xff133E87),
                        ),
                      ),
                      onSaved: (name) {
                        _formData['name'] = (name?.trim().isEmpty ?? true)
                            ? ''
                            : name ?? ''; // Valor padrão
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Editar Email",
                      style: TextStyle(
                        fontFamily: "PoppinsBold",
                        fontSize: 18,
                        color: Color(0xff133E87),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      initialValue:
                          _formData['email']?.toString() ?? '', // Valor padrão
                      style: TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Color(0xff133E87),
                        ),
                      ),
                      onSaved: (email) {
                        _formData['email'] = (email?.trim().isEmpty ?? true)
                            ? ''
                            : email ?? ''; // Valor padrão
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Alterar Senha",
                      style: TextStyle(
                        fontFamily: "PoppinsBold",
                        fontSize: 18,
                        color: Color(0xff133E87),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      obscureText: _obscureText,
                      style: TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color(0xff133E87),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Color(0xff133E87),
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                      onSaved: (password) {
                        _formData['password'] =
                            (password?.trim().isEmpty ?? true)
                                ? ''
                                : password ?? ''; // Valor padrão
                      },
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Color(0xffA8DADC)),
                      onPressed: _submitEdit,
                      child: Text(
                        "Salvar alterações",
                        style: TextStyle(
                            fontFamily: "PoppinsLight",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
