import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:breakpoint_app/providers/vice_provider.dart';
import 'package:breakpoint_app/widgets/medal_list.dart';

class Achievements extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viceProvider = Provider.of<ViceProvider>(context);
    final viceList = viceProvider.vices;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MedalList(vicesList: viceList),
      ),
    );
  }
}
