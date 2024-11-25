import 'package:flutter/foundation.dart';
import 'package:breakpoint_app/model/Vice.dart';

class ViceProvider with ChangeNotifier {
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
