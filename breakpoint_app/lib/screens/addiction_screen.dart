// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:breakpoint_app/widgets/vice_form.dart';
import 'package:breakpoint_app/model/Vice.dart';
import 'package:breakpoint_app/widgets/vice_list.dart';

class Addiction extends StatefulWidget {
  final void Function(List<Vice>) onSubmit;

  const Addiction({super.key, required this.onSubmit});

  @override
  State<Addiction> createState() => _AddictionState();
}

class _AddictionState extends State<Addiction> {
  final List<Vice> _vicesList = [
    Vice(typeofvice: 'Cigarro', datesobriety: DateTime.now(), viceType: 'Fumo'),
    Vice(
        typeofvice: 'Bebida Alcoólica',
        datesobriety: DateTime(2024, 7, 20),
        viceType: 'Alcool'),
    Vice(
        typeofvice: 'Jogos de Azar',
        datesobriety: DateTime(2024, 4, 10),
        viceType: 'Jogos de Azar'),
    Vice(
        typeofvice: 'Comer Doces',
        datesobriety: DateTime(2023, 10, 5),
        viceType: 'Comida'),
    Vice(
        typeofvice: 'Uso Excessivo de Smartphone',
        datesobriety: DateTime(2022, 10, 1),
        viceType: 'Tecnologia'),
  ];

  @override
  void initState() {
    _submitList();
    super.initState();
  }

  void _addVice(String typeofvice, DateTime dateSelect, String viceType) {
    Vice newVice = Vice(
      typeofvice: typeofvice,
      datesobriety: dateSelect,
      viceType: viceType,
    );

    setState(() {
      _vicesList.add(newVice);
    });
  }

  void _removeVice(Vice vice) {
    setState(() {
      _vicesList.removeWhere((v) =>
          v.typeofvice == vice.typeofvice &&
          v.datesobriety == vice.datesobriety);
    });
  }

  void _submitList() {
    widget.onSubmit(_vicesList);
  }

  void _openViceForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xffCBDCEB),
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
        child: ViceList(
          vicesList: _vicesList,
          onDelete: _removeVice,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF134B70),
        foregroundColor: Colors.white,
        onPressed: _openViceForm,
        child: Icon(Icons.add),
      ),
    );
  }
}
