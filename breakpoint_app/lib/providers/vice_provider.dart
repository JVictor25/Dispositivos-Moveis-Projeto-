import 'package:breakpoint_app/data/data.dart';
import 'package:flutter/foundation.dart';
import 'package:breakpoint_app/model/Vice.dart';

class ViceProvider with ChangeNotifier {
  final List<Vice> _vicesList = exampleVices;

  List<Vice> get vices => List.unmodifiable(_vicesList);

  void addVice(Vice vice) {
    _vicesList.add(vice);
    notifyListeners(); // Notifica os ouvintes da mudança
  }

  void removeVice(Vice vice) {
    _vicesList.removeWhere((v) =>
        v.typeofvice == vice.typeofvice &&
        v.datesobriety == vice.datesobriety &&
        v.viceType == vice.viceType);
    notifyListeners(); // Notifica os ouvintes da mudança
  }
}
