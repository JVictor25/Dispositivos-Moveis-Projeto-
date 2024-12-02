// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:breakpoint_app/model/Vice.dart';
import 'package:breakpoint_app/widgets/Progress.dart';
import 'package:breakpoint_app/widgets/clock.dart';
import 'package:flutter/material.dart';

class ViceDetail extends StatelessWidget{
  Vice vice;
  ViceDetail({super.key, required this.vice});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color(0xfff5f5f5),
        backgroundColor: Color(0xff133E87),
        title: Text(vice.typeofvice),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xffE6E6FA),
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Progress(vice: vice),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Resumo", style: TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),),
                              Clock(vice: vice),
                ],
              ),
            ],
          ),
          )),
    );
  }
}