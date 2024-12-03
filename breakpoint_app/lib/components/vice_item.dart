// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'package:breakpoint_app/widgets/Progress.dart';
import 'package:breakpoint_app/widgets/clock.dart';
import 'package:breakpoint_app/data/data.dart';
import 'package:breakpoint_app/model/Vice.dart';
import 'package:breakpoint_app/providers/vice_provider.dart';
import 'package:breakpoint_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViceItem extends StatefulWidget {
  const ViceItem({super.key, required this.vice});

  final Vice vice;
  @override
  State<ViceItem> createState() => _ViceItemState();
}

class _ViceItemState extends State<ViceItem> {

  Future<bool?> alertDelete() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Excluir hábito?"),
          content: Text("Tem certeza que deseja excluir este hábito?"),
          actions: <Widget>[
            TextButton(
              child: Text("Confirmar"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(AppRoutes.VICEDETAIL, arguments: widget.vice),
      child: Dismissible(
        key: Key(widget.vice.typeofvice),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) {
          return alertDelete();
        },
        onDismissed: (direction) {
          Provider.of<ViceProvider>(context, listen: false).removeVice(widget.vice);
        },
        background: Card(
          shadowColor: Colors.black87.withOpacity(0.3),
          color: Colors.red,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.centerRight,
            child: Icon(Icons.delete, color: Colors.white)),
        ),
        child: Card(
          shadowColor: Colors.black87.withOpacity(0.3),
          color: Color(0xffE6E6FA),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      iconMap[widget.vice.viceType.toLowerCase()] ??
                          Icons.add_box,
                      size: 24,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        widget.vice.typeofvice,
                        style: TextStyle(
                            fontFamily: 'PoppinsRegular',
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tempo de abstinência:",
                          style: TextStyle(
                            fontFamily: 'PoppinsRegular',
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        Clock(date: widget.vice.datesobriety),
                      ],
                    ),
                    Progress(date:widget.vice.datesobriety),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
