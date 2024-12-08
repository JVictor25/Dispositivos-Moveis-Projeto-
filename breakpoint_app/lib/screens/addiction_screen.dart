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

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ViceList(
          onDelete: (vice) => viceProvider.removeVice(vice, Provider.of<ActiveUser>(context, listen: false).currentUser!),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffA8DADC),
        foregroundColor: const Color(0xFF134B70),
        onPressed: () => Navigator.pushNamed(
                context, 
                AppRoutes.VICEFORM, 
                arguments: null,
              ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
