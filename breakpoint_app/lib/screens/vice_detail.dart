// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:breakpoint_app/model/Vice.dart';
import 'package:breakpoint_app/providers/active_user.dart';
import 'package:breakpoint_app/providers/vice_provider.dart';
import 'package:breakpoint_app/widgets/Progress.dart';
import 'package:breakpoint_app/widgets/calendar.dart';
import 'package:breakpoint_app/widgets/clock.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ViceDetail extends StatefulWidget {
  Vice vice;
  ViceDetail({super.key, required this.vice});

  @override
  State<ViceDetail> createState() => _ViceDetailState();
}

class _ViceDetailState extends State<ViceDetail> {
  @override
  Widget build(BuildContext context) {
    final viceProvider = Provider.of<ViceProvider>(context);
    final vice = viceProvider.vices.firstWhere((v) => v.id == widget.vice.id);
    final baseDate = vice.reseted ? vice.datesobriety : vice.dateCreation!;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color(0xfff5f5f5),
        backgroundColor: Color(0xff133E87),
        title: Text(vice.viceType),
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
                      SizedBox(height: 20),
                      Progress(date: baseDate),
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Tempo de sobriedade: ",
                        style: TextStyle(
                          fontFamily: 'PoppinsRegular',
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Clock(date: baseDate),
                      vice.impactType == 'tempo'
                          ? Column(
                              children: [
                                Text(
                                  "Tempo economizado: ",
                                  style: TextStyle(
                                    fontFamily: 'PoppinsRegular',
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${((double.tryParse(vice.impactValue ?? '0') ?? 0) * (baseDate.difference(vice.datesobriety).inDays < 0 ? 0 : baseDate.difference(vice.datesobriety).inDays)).toStringAsFixed(2)} horas',
                                  style: TextStyle(
                                    fontFamily: 'PoppinsRegular',
                                    fontSize: 14,
                                    color: Color(0xff133E87),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          : vice.impactType == 'dinheiro'
                              ? Column(
                                  children: [
                                    Text(
                                      "Dinheiro economizado: ",
                                      style: TextStyle(
                                        fontFamily: 'PoppinsRegular',
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'R\$ ' +
                                          NumberFormat.currency(
                                            locale: 'pt_BR',
                                            symbol: '',
                                            decimalDigits: 2,
                                          ).format(
                                            ((double.tryParse(
                                                        vice.impactValue!) ??
                                                    0) *
                                                ((baseDate
                                                            .difference(
                                                                vice.datesobriety)
                                                            .inDays <
                                                        0)
                                                    ? 0
                                                    : baseDate
                                                        .difference(
                                                            vice.datesobriety)
                                                        .inDays)),
                                          ),
                                      style: TextStyle(
                                        fontFamily: 'PoppinsRegular',
                                        fontSize: 14,
                                        color: Color(0xff133E87),
                                        fontWeight: FontWeight.bold,
                                      ),
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
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 50),
              Text(
                "Minhas motivações",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'PoppinsRegular',
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: double.infinity,
                height: 60,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  "\"" + vice.description + "\"",
                  style: TextStyle(
                    fontFamily: 'PoppinsRegular',
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 50),
              Calendar(
                dateCreation: vice.dateCreation!,
                datesobriety: vice.datesobriety,
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  viceProvider
                      .resetVice(
                          widget.vice.id,
                          Provider.of<ActiveUser>(context, listen: false)
                              .currentUser!)
                      .then((value) {
                    Navigator.of(context).pop();
                    viceProvider.fetchVices(
                        Provider.of<ActiveUser>(context, listen: false)
                            .currentUser!);
                  });
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Color(0xff133E87),
                ),
                child: Text(
                  "Reiniciar Cronômetro",
                  style: TextStyle(
                    fontFamily: "PoppinsRegular",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
