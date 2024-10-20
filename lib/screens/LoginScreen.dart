import 'package:flutter/material.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                const Text(
                  "Login",
                  style: TextStyle(
                    fontFamily: 'Garamond',
                    fontSize: 30,
                    color: Color(0xFF37474F),
                  ),
                ),
                const SizedBox(height: 20),
                const Icon(
                  Icons.login_outlined,
                  size: 100,
                  color: Color(0xFF37474F),
                ),
                const SizedBox(height: 20),
                const SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      label: Text("Usuário"),
                      hintText: 'Inserir usuário...',
                      prefixIcon: Icon(Icons.person),
                      hintStyle: TextStyle(
                        fontFamily: 'Garamond',
                        fontSize: 16,
                        color: Color(0xFF37474F),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      label: Text("Senha"),
                      hintText: 'Inserir senha...',
                      prefixIcon: Icon(Icons.lock),
                      hintStyle: TextStyle(
                        fontFamily: 'Garamond',
                        fontSize: 16,
                        color: Color(0xFF37474F),
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
                            value: false,
                            onChanged: (bool) {
                              //Ainda não foi implementado
                            },
                          ),
                          const Text(
                            "Lembre-me",
                            style: TextStyle(
                              fontFamily: 'Garamond',
                              fontSize: 16,
                              color: Color(0xFF37474F),
                            ),
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
                              child: const Text(
                                "Esqueceu a senha?",
                                style: TextStyle(
                                  fontFamily: 'Garamond',
                                  fontSize: 16,
                                  color: Color(0xFF37474F),
                                ),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    //Ainda não foi implementado
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 40),
                      backgroundColor: Color(0xFF37474F)),
                  child: const Text(
                    "Acessar",
                    style: TextStyle(
                      fontFamily: 'Garamond',
                      fontSize: 16,
                      color: Color(0xFFADD8E6),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    //Ainda não foi implementado
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 40),
                      backgroundColor: Color(0xFFADD8E6)),
                  child: const Text(
                    "Criar minha conta",
                    style: TextStyle(
                      fontFamily: 'Garamond',
                      fontSize: 16,
                      color: Color(0xFF37474F),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
