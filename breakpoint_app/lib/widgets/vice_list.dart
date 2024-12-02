// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:breakpoint_app/components/vice_item.dart';

import '../model/Vice.dart';
import 'package:flutter/material.dart';

class ViceList extends StatelessWidget {
   final Function(Vice) onDelete;

  const ViceList({
    super.key,
    required List<Vice> vicesList,
    required this.onDelete,
  }) : _vicesList = vicesList;

  final List<Vice> _vicesList;
   @override
  Widget build(BuildContext context) {
    if (_vicesList.isEmpty) {
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
      itemCount: _vicesList.length,
      itemBuilder: (BuildContext context, int index) {
        return ViceItem(vice: _vicesList.elementAt(index));
      },
    );
  }
}