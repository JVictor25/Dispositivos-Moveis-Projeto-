// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers

import 'package:breakpoint_app/model/Vice.dart';
import 'package:breakpoint_app/providers/active_user.dart';
import 'package:breakpoint_app/providers/user_service.dart';
import 'package:breakpoint_app/routes/app_routes.dart';
import 'package:breakpoint_app/widgets/register_user.dart';
import 'package:flutter/material.dart';
import 'package:breakpoint_app/model/User.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  bool _obscureText = true;

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isBiometricAvailable = false;

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  void _showRegisterUser() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => Registeruser()),
    );
  }

  Future<void> _checkBiometrics() async {
    try {
      final isAvailable = await _localAuth.canCheckBiometrics;
      setState(() {
        _isBiometricAvailable = isAvailable;
      });
    } catch (e) {
      print("Erro ao verificar biometria: $e");
    }
  }

  void _submitLogin() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();

    final loginResult = await Provider.of<UserService>(context, listen: false)
        .loginUser(
            _formData['email'] as String, _formData['password'] as String);
    if (loginResult != null) {
      Provider.of<ActiveUser>(context, listen: false)
          .setCurrentUser(loginResult as String);
      Navigator.of(context).pushNamed(AppRoutes.HOMESCREEN);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao efetuar login!'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _loginBiometrics() async {
    final userService = Provider.of<UserService>(context, listen: false);
    final token = await userService.loginWithBiometrics();

    if (token != null) {
      Provider.of<ActiveUser>(context, listen: false)
          .setCurrentUser(token);
      Navigator.of(context).pushNamed(AppRoutes.HOMESCREEN);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao autenticar com biometria!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
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
                child: Form(
                  key: _formKey,
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
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 16, 0),
                                        child: Text("Login",
                                            style: TextStyle(
                                              fontFamily: "PoppinsRegular",
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
                        padding:
                            EdgeInsets.symmetric(vertical: 35, horizontal: 16),
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        child: TextFormField(
                          initialValue: _formData['email']?.toString(),
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
                                    fontFamily: "PoppinsRegular",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffA8DADC)),
                              ),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Color(0xffA8DADC),
                              )),
                          onSaved: (email) => _formData['email'] = email ?? '',
                          validator: (_email) {
                            final email = _email ?? '';
          
                            if (email.trim().isEmpty) {
                              return 'Email é obrigatório';
                            }
          
                            final emailRegex = RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                            if (!emailRegex.hasMatch(email)) {
                              return 'Email inválido';
                            }
          
                            final namePart = email.split('@')[0];
                            if (namePart.length < 4) {
                              return 'Pelo menos 5 caracteres antes do @';
                            }
          
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        child: TextFormField(
                          initialValue: _formData['password']?.toString(),
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
                                    fontFamily: "PoppinsRegular",
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
                          onSaved: (password) =>
                              _formData['password'] = password ?? '',
                          validator: (_password) {
                            final password = _password ?? '';
          
                            if (password.trim().isEmpty) {
                              return 'Senha é obrigatório';
                            }
          
                            if (password.trim().length < 5) {
                              return 'Precisa no mínimo de 5 letras.';
                            }
          
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                        child: ElevatedButton(
                          onPressed: () {
                            _submitLogin();
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              backgroundColor: Color(0xffA8DADC)),
                          child: Text(
                            "Entrar",
                            style: TextStyle(
                                fontFamily: "PoppinsRegular",
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
                                  fontFamily: "PoppinsRegular",
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
                                      fontFamily: "PoppinsRegular",
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffA8DADC),
                                      decoration: TextDecoration.underline,
                                      decorationColor: Color(0xffA8DADC)),
                                )),
                          ],
                        ),
                      ),
                      if (_isBiometricAvailable)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: ElevatedButton.icon(
                            onPressed: _loginBiometrics,
                            icon: Icon(Icons.fingerprint, color: Colors.black),
                            label: Text(
                              "Entrar com Biometria",
                              style: TextStyle(
                                fontFamily: "PoppinsRegular",
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              backgroundColor: Color(0xffA8DADC),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
