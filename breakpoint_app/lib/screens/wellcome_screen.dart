import 'package:flutter/material.dart';

class Wellcome extends StatelessWidget {
  const Wellcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFF3A1078), Color(0xFF836FFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "BreakPoint",
              textDirection: TextDirection.ltr,
              style: Theme.of(context).textTheme.bodyLarge
            ),
            const SizedBox(
              height: 40,
            ),
            const Icon(
              Icons.handshake_outlined,
              size: 150,
              color: Colors.white,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Bem-Vindo(a)!",
              textDirection: TextDirection.ltr,
              style: Theme.of(context).textTheme.bodyLarge
            ),
            Text(
              "Estamos aqui para ajudar você a ter mais controle e equilíbrio em sua jornada.\n Vamos começar?",
              textDirection: TextDirection.ltr,
              style: Theme.of(context).textTheme.bodyMedium,
              softWrap: true,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'home');
                },
                backgroundColor: const Color(0xFF3A1078),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}
