import 'package:flutter/material.dart';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  @override
  Widget build(BuildContext context) {
    DateTime _birth = DateTime.now();

    void _showDatePicker() {
      showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1960),
              lastDate: DateTime.now())
          .then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _birth = pickedDate;
        });
      });
    }

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
                colors: [Color(0xFFADD8E6), Color(0xFFB39DDB)],
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
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: TextField(
                      decoration: InputDecoration(
                        label: Text(
                          "Usuário",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        hintText: 'Usuário',
                        prefixIcon: Icon(Icons.person),
                        hintStyle: Theme.of(context).textTheme.bodySmall,
                      ),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          label: Text(
                            "Senha",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          hintText: 'Senha',
                          prefixIcon: Icon(Icons.lock),
                          hintStyle: Theme.of(context).textTheme.bodySmall),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          label: Text(
                            "Confirmar senha",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          hintText: 'Confirmar senha',
                          prefixIcon: Icon(Icons.lock),
                          hintStyle: Theme.of(context).textTheme.bodySmall),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      TextButton(
                          onPressed: (){
                            _showDatePicker();
                          },
                          child: Text(
                            "Data de nascimento",
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
