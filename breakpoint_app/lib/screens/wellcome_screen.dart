// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:breakpoint_app/model/User.dart';

class Wellcome extends StatelessWidget {
  const Wellcome({super.key});

  @override
  Widget build(BuildContext context) {

    User _visitor = User(
      username: "Visitante",
      email: "Visitante@breakpoin.com",
      password: "000",
      );

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xffF5F5F5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle, 
                  boxShadow: [ BoxShadow(
                    color: Color(0xff424242).withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(3, 3),
                  )
                ]),
                child: Image.asset('assets/images/target.png', width: 200)),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Bem-Vindo(a) ao Breakpoint!",
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontSize: 18,
                  color: Color(0xff424242),
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Estamos aqui para ajudá-lo a focar em seu objetivo e alcançar suas metas. \n Vamos começar?",
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontFamily: 'PoppinsLight',
                fontSize: 14,
                color: Color(0xff424242),
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    color: Colors.black87,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('home', arguments: _visitor);
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              backgroundColor: Color(0xffA8DADC)),
                          child: Text(
                            "Visitante",
                            style: TextStyle(
                                fontFamily: "PoppinsLight",
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                        ),
                        SizedBox(
                          height: 10
                        ),
                        Text("Já tem uma conta?", style: TextStyle(
                                fontSize: 14,
                                color: Color(0xffA8DADC))),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'login');
                          },
                          style: OutlinedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              backgroundColor: Colors.transparent,
                              side: BorderSide(color: Color(0xffA8DADC), width: 1)
                              ),
                          child: Text(
                            "Entrar",
                            style: TextStyle(
                                fontFamily: "PoppinsLight",
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffA8DADC)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
