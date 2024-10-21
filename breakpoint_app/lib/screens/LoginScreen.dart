import 'package:flutter/material.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

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
                colors: [Color(0xFFADD8E6), Color(0xFFB39DDB)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text("Entrar", style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 20),
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
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: false,
                              onChanged: (bool) {
                                //Ainda não foi implementado
                              },
                            ),
                            Text(
                              "Lembre-me",
                              style: Theme.of(context).textTheme.bodyMedium,
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
                                        .bodyMedium!
                                        .copyWith(
                                          decoration: TextDecoration.underline,
                                        ))),
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
                      //Ainda não foi implementado
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 40),
                        backgroundColor: const Color(0xFF37474F)),
                    child: const Text(
                      "Acessar",
                      style: TextStyle(
                        fontFamily: 'Garamond',
                        fontSize: 16,
                        color: Color(0xFFADD8E6),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Não tem uma conta?",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'register');
                          },
                          child: Text(
                            "Increver-se",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FloatingActionButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      backgroundColor: const Color(0xFFADD8E6),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF37474F),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
