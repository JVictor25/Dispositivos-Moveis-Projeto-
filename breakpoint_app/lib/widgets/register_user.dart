import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Registeruser extends StatefulWidget {
  final void Function(String, String, String, DateTime) onSubmit;

  const Registeruser({super.key, required this.onSubmit});

  @override
  State<Registeruser> createState() => _RegisteruserState();
}

class _RegisteruserState extends State<Registeruser> {
  TextEditingController _birthController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late DateTime _birth = DateTime.now();
  String? _selectedAvatar;

  final List<String> avatars = [
    'assets/images/avatar1.png',
    'assets/images/avatar2.png',
    'assets/images/avatar3.png',
    'assets/images/avatar4.png',
    'assets/images/avatar5.png',
    'assets/images/avatar6.png',
  ];

  void _submitUser() {
    String _birthUser = _birthController.text;
    String _username = _usernameController.text;
    String _password = _passwordController.text;

    if (_birthUser.isEmpty || _username.isEmpty || _password.isEmpty || _selectedAvatar!.isEmpty) {
      showDialog(
          context: context,
          builder: (BuilderContext) {
            return AlertDialog(
              backgroundColor: Color(0xffCBDCEB),
              title: Text(
                "Erro!!",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              content: Text("Por favor preencha todos os campos e tente efetuar o cadastro novamente!",
                  style: Theme.of(context).textTheme.bodySmall,),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Tentar novamente",
                      style: Theme.of(context).textTheme.titleSmall,
                    ))
              ],
            );
          });
      return;
    }

    widget.onSubmit(_selectedAvatar!, _username, _password, _birth);
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

  void _showAvatarSelectionModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color:  Color(0xffCBDCEB),
          padding: EdgeInsets.all(16),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Número de colunas
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: avatars.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedAvatar = avatars[index];
                  });
                  Navigator.pop(context); // Fecha o modal
                },
                child: Image.asset(avatars[index]),
              );
            },
          ),
        );
      },
    );
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  Column(
                    children: [
                      Text(
                        _selectedAvatar == null
                            ? "Selecione um avatar: "
                            : "Avatar selecionado:",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      _selectedAvatar == null
                          ? IconButton(
                              onPressed: () {
                                _showAvatarSelectionModal();
                              },
                              icon: Icon(
                                Icons.add_box_outlined,
                                size: 80,
                                color: Colors.white,
                              ),
                            )
                          : TextButton(
                              onPressed: () {
                                _showAvatarSelectionModal();
                              },
                              child:
                                  Image.asset(_selectedAvatar!, width: 80)),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Informe seus dados: ", style: Theme.of(context).textTheme.labelMedium,),
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
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xff133E87),
                        ),
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
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color(0xff133E87),
                        ),
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
                          prefixIcon: Icon(
                            Icons.calendar_today,
                            color: Color(0xff133E87),
                          ),
                          hintStyle: Theme.of(context).textTheme.labelMedium,
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
                        backgroundColor: Color(0xff133E87)),
                    child: Text(
                      "Cadastrar",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
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
