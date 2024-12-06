import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:breakpoint_app/model/Vice.dart';
import 'package:breakpoint_app/providers/vice_provider.dart';
import 'package:breakpoint_app/widgets/vice_form.dart';

class ViceFormPage extends StatelessWidget {
  final Vice? existingVice; // Objeto Vice opcional para edição
  final bool isModifying;

  const ViceFormPage({
    Key? key,
    this.existingVice,
    this.isModifying = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isModifying ? 'Editar Vício' : 'Novo Vício'),
        backgroundColor: const Color(0xFF134B70),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ViceForm(
          existingVice: existingVice, // Passa o vice existente para o formulário
          isModifying: isModifying,
          onSubmit: (typeofvice, dateSelect, viceType, impactType, impactValue) {
  try {
    if (isModifying && existingVice != null) {
      // Atualiza o objeto existente
      final updatedVice = existingVice!.copyWith(
        typeofvice: typeofvice,
        datesobriety: dateSelect,
        viceType: viceType,
        impactType: impactType,
        impactValue: impactValue,
      );

      // Atualiza via Provider
      Provider.of<ViceProvider>(context, listen: false)
          .updateVice(updatedVice);
    } else {
      // Cria um novo objeto Vice
      final newVice = Vice(
        typeofvice: typeofvice,
        datesobriety: dateSelect,
        dateCreation: DateTime.now(), // Data atual para novos vícios
        viceType: viceType,
        impactType: impactType,
        impactValue: impactValue,
      );

      // Adiciona à lista de vícios via Provider
      Provider.of<ViceProvider>(context, listen: false)
          .addVice(newVice);
    }

    // Navega para a página anterior
    Navigator.of(context).pop();
  } catch (e) {
    debugPrint("Erro ao salvar/modificar vício: $e");
  }
        },
        ),
      ),
    );
  }
}
