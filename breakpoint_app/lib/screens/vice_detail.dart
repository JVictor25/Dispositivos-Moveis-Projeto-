// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, unused_field, prefer_interpolation_to_compose_strings
import 'package:breakpoint_app/model/Vice.dart';
import 'package:breakpoint_app/widgets/Progress.dart';
import 'package:breakpoint_app/widgets/calendar.dart';
import 'package:breakpoint_app/widgets/clock.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViceDetail extends StatefulWidget {
  Vice vice;
  ViceDetail({super.key, required this.vice});

  @override
  State<ViceDetail> createState() => _ViceDetailState();
}

class _ViceDetailState extends State<ViceDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color(0xfff5f5f5),
        backgroundColor: Color(0xff133E87),
        title: Text(widget.vice.typeofvice),
      ),
      body: SingleChildScrollView(
          child: Container(
        color: Color(0xffE6E6FA),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Progress(date: widget.vice.datesobriety),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Resumo",
                      style: TextStyle(
                          fontFamily: 'PoppinsRegular',
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Tempo de sobriedade: ",
                      style: TextStyle(
                          fontFamily: 'PoppinsRegular',
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Clock(date: widget.vice.datesobriety),
                    widget.vice.impactType == 'time'
                        ? Column(
                            children: [
                              Text(
                                "Tempo economizado: ",
                                style: TextStyle(
                                    fontFamily: 'PoppinsRegular',
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${(widget.vice.impactValue * widget.vice.dateCreation.difference(widget.vice.datesobriety).inDays).toString()} horas',
                                style: TextStyle(
                                  fontFamily: 'PoppinsRegular',
                                  fontSize: 14,
                                  color: Color(0xff133E87),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        : widget.vice.impactType == 'money'
                            ? Column(
                                children: [
                                  Text(
                                    "Dinheiro economizado: ",
                                    style: TextStyle(
                                        fontFamily: 'PoppinsRegular',
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'R\$ ' +
                                        NumberFormat.currency(
                                          locale: 'pt_BR',
                                          symbol: '',
                                          decimalDigits: 2,
                                        ).format(widget.vice.impactValue *
                                            widget.vice.dateCreation
                                                .difference(
                                                    widget.vice.datesobriety)
                                                .inDays),
                                    style: TextStyle(
                                        fontFamily: 'PoppinsRegular',
                                        fontSize: 14,
                                        color: Color(0xff133E87),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Text(
                                    "Imensurável...",
                                    style: TextStyle(
                                        fontFamily: 'PoppinsRegular',
                                        fontSize: 14,
                                        color: Color(0xff133E87),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                ],
                              )
                  ],
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Calendar(
                      dateCreation: widget.vice.dateCreation,
                      datesobriety: widget.vice.datesobriety),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () {
                    setState(() {
                      widget.vice = widget.vice.copyWith(datesobriety: DateTime.now());
                    });
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Color(0xff133E87)),
                    child: Text(
                      "Reiniciar Cronômetro",
                      style: TextStyle(
                          fontFamily: "PoppinsRegular",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
