import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:breakpoint_app/model/Vice.dart';
import 'package:breakpoint_app/providers/vice_provider.dart';
import 'package:breakpoint_app/widgets/vice_form.dart';
import 'package:breakpoint_app/widgets/vice_list.dart';

class Addiction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viceProvider = Provider.of<ViceProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ViceList(
          vicesList: viceProvider.vices,
          onDelete: (vice) => viceProvider.removeVice(vice),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffA8DADC),
        foregroundColor: Color(0xFF134B70),
        onPressed: () => _openViceForm(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _openViceForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xffCBDCEB),
          content: ViceForm(
            onSubmit: (typeofvice, dateSelect, viceType, impactType, impactValue) {
              final newVice = Vice(
                typeofvice: typeofvice,
                datesobriety: dateSelect,
                dateCreation: dateSelect,
                viceType: viceType,
                impactType: impactType, // Novo campo para o tipo de impacto
                impactValue: impactValue, // Novo campo para o valor do impacto
              );
              Provider.of<ViceProvider>(context, listen: false).addVice(newVice);
            },
            isModifying: false,
          ),
        );
      },
    );
  }
}
