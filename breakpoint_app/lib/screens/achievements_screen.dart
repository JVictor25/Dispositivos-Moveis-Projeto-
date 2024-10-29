import 'package:breakpoint_app/model/Vice.dart';
import 'package:breakpoint_app/widgets/medal_list.dart';
import 'package:flutter/material.dart';

class Achievements extends StatelessWidget{
  final List<Vice> viceList;
  
  const Achievements({
    super.key,
    required this.viceList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MedalList(vicesList: viceList),
      ),
    );
  }
}