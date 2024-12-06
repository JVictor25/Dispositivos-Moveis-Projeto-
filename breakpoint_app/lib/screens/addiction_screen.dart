import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart';
import 'package:breakpoint_app/model/Vice.dart';
import 'package:breakpoint_app/providers/vice_provider.dart';
import 'package:breakpoint_app/widgets/vice_list.dart';
import 'package:breakpoint_app/routes/app_routes.dart';
import 'vice_form_screen.dart'; // Importa a nova página

class Addiction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viceProvider = Provider.of<ViceProvider>(context);

    // Verifique se há um vício na lista. Se houver, o FAB não adiciona um novo.
    final bool canAddVice = viceProvider.vices.isEmpty;

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
        backgroundColor: const Color(0xffA8DADC),
        foregroundColor: const Color(0xFF134B70),
        onPressed: canAddVice
            ? () => Navigator.pushNamed(
                context, 
                AppRoutes.VICEFORMPAGE, 
                arguments: {
                  'vice': null,  // Não passa vice, para indicar que é um novo vício
                  'isModifying': false,  // Indica que estamos no modo de adicionar
                },
              )
            : null,  // Desabilita o botão se já houver um vício
        child: const Icon(Icons.add),
      ),
    );
  }
}
