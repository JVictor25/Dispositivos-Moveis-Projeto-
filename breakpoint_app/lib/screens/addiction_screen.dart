import 'package:breakpoint_app/providers/active_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:breakpoint_app/providers/vice_provider.dart';
import 'package:breakpoint_app/widgets/vice_list.dart';
import 'package:breakpoint_app/routes/app_routes.dart';

class Addiction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viceProvider = Provider.of<ViceProvider>(context);
    final activeUser = Provider.of<ActiveUser>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ViceList(
          onDelete: (vice) =>
              viceProvider.removeVice(vice, activeUser.currentUser!),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF134B70),
        foregroundColor: Colors.white,
        onPressed: () {
          final activeUser = Provider.of<ActiveUser>(context, listen: false);
          Navigator.pushNamed(
            context,
            AppRoutes.VICEFORM,
            arguments: null,
          )..then((_) {
              final activeUser =
                  Provider.of<ActiveUser>(context, listen: false);
              if (activeUser.currentUser != null) {
                viceProvider.fetchVicesAndSync(
                    activeUser.currentUser!); // Passa diretamente como string
              }
            });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
