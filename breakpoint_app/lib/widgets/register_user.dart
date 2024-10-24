import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Registeruser extends StatefulWidget {
  final void Function(String, String, DateTime) onSubmit;

  const Registeruser({super.key, required this.onSubmit});

  @override
  State<Registeruser> createState() => _RegisteruserState();
}

class _RegisteruserState extends State<Registeruser> {
  TextEditingController _birthController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late DateTime _birth = DateTime.now();

  void _submitUser() {
    String _birthUser = _birthController.text;
    String _username = _usernameController.text;
    ;
    String _password = _passwordController.text;

    if (_birthUser.isEmpty || _username.isEmpty || _password.isEmpty) {
      showDialog(
          context: context,
          builder: (BuilderContext) {
            return AlertDialog(
              title: Text("Erro!!", style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center,),
              content: Text("Nome de Usuário ou Senha não foram informados!", style: Theme.of(context).textTheme.displaySmall,textAlign: TextAlign.center),
              actions: [
                TextButton(onPressed: () {
                  Navigator.of(context).pop();
                }, child: Text("Tentar novamente", style: Theme.of(context).textTheme.displaySmall,))
              ],
            );
          });
      return;
    }

    widget.onSubmit(_username, _password, _birth);
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950, 1, 1),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _birth = pickedDate;
        _birthController.text = DateFormat('dd/MM/y').format(pickedDate);
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
                      controller: _usernameController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        label: Text("Usuário",
                            style: Theme.of(context).textTheme.labelLarge),
                        prefixIcon: Icon(Icons.person),
                      ),
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
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    child: TextField(
                        controller: _birthController,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          label: Text(
                            "Data de nascimento",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          hintText: "dd/MM/yyyy",
                          hintStyle: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              color: Colors.grey),
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        keyboardType: TextInputType.datetime,
                        readOnly: true,
                        onTap: _showDatePicker),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _submitUser();
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 40),
                        backgroundColor: Color(0xFF3A1078)),
                    child: Text(
                      "Cadastrar",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Já tem uma conta?",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Acesse aqui",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.white
                                ),
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
