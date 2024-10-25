import 'package:flutter/material.dart';
import 'package:breakpoint_app/widgets/vice_form.dart';
import 'package:breakpoint_app/model/Vice.dart';
import 'package:breakpoint_app/widgets/vice_list.dart';

class Addiction extends StatefulWidget {
  const Addiction({super.key});

  @override
  State<Addiction> createState() => _AddictionState();
}

class _AddictionState extends State<Addiction> {
  List<Vice> _vicesList = [
    Vice(typeofvice: "Álcool", datesobriety: DateTime(2022))
  ];

  void _addVice(String typeofvice, DateTime dateSelect) {
    Vice _newVice = Vice(
      typeofvice: typeofvice,
      datesobriety: dateSelect,
    );

    setState(() {
      _vicesList.add(_newVice);
    });
  }

  void _openViceForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: ViceForm(
            onSubmit: _addVice,
            isModifying: false,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ViceList(vicesList: _vicesList),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(19, 75, 112, 1),
        foregroundColor: Colors.white,
        onPressed: _openViceForm,
        child: Icon(Icons.add),
      ),
    );
  }
}
