import 'package:flutter/material.dart';

class Registeruser extends StatefulWidget {
  final void Function(String, String, DateTime) onSubmit;

  const Registeruser({super.key, required this.onSubmit});

  @override
  State<Registeruser> createState() => _RegisteruserState();
}

class _RegisteruserState extends State<Registeruser> {
  late DateTime _birth;

  void submitUser() {}

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime(2008),
            firstDate: DateTime(1950),
            lastDate: DateTime(2008))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _birth = pickedDate;
      });
    });
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
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF3A1078),
                  Color(0xFF6A5ACD),
                  Color(0xFF836FFF)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Cadastrar",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        label: Text(
                          "Usuário",
                          style: Theme.of(context).textTheme.labelLarge
                        ),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          label: Text(
                            "Senha",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                          label: Text(
                            "Confirmar senha",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          prefixIcon: Icon(Icons.lock),
                          ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            _showDatePicker();
                          },
                          child: Text(
                            "Data de nascimento",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                          )),
                    ],
                  ),
                  FloatingActionButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      backgroundColor: const Color(0xFFADD8E6),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF37474F),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
