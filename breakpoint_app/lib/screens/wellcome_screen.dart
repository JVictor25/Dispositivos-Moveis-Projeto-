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
            gradient: LinearGradient(colors: [
          Color(0xff133E87),
          Color(0xFF608BC1),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "BreakPoint",
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontFamily: 'PoppinsLight',
                fontSize: 30,
                color: Color(0xffF3F3E0),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Image.asset('assets/images/handshake.png', width: 150),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Bem-Vindo(a)!",
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontFamily: 'PoppinsLight',
                fontSize: 30,
                color: Color(0xffF3F3E0),
              ),
            ),
            Text(
              "Estamos aqui para ajudar você a ter mais controle e equilíbrio em sua jornada.\n \nVamos começar?",
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontFamily: 'PoppinsLight',
                fontSize: 16,
                color: Color(0xffF3F3E0),
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'login');
              },
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xffF3F3E0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
