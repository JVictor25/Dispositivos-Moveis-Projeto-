// ignore_for_file: use_super_parameters, prefer_const_constructors

import 'package:breakpoint_app/providers/active_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/vice_item.dart';
import '../model/Vice.dart';
import '../providers/vice_provider.dart';

class ViceList extends StatefulWidget {
  final Function(Vice) onDelete;

  const ViceList({
    Key? key,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<ViceList> createState() => _ViceListState();
}

class _ViceListState extends State<ViceList> {
  @override
  void initState() {
    super.initState();
    _fetchVices();
  }

  Future<void> _fetchVices() async {
    final activeUser = Provider.of<ActiveUser>(context, listen: false);
    final provider = Provider.of<ViceProvider>(context, listen: false);
    await provider.fetchVices(activeUser.currentUser!);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ViceProvider>(
      builder: (context, viceProvider, child) {
        if (viceProvider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (viceProvider.vices.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/brokenchain.png', width: 150),
                const Text(
                  'Encontre o seu autocontrole!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: viceProvider.vices.length,
          itemBuilder: (context, index) {
            final vice = viceProvider.vices[index];
            return ViceItem(
              vice: vice,
            );
          },
        );
      },
    );
  }
}
