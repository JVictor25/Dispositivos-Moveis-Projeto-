import 'package:breakpoint_app/providers/vice_service.dart';
import 'package:flutter/foundation.dart';
import 'package:breakpoint_app/model/Vice.dart';
import 'package:breakpoint_app/database/database_helper.dart';
import 'package:flutter/material.dart';

class ViceProvider with ChangeNotifier {
  final ViceService _viceService = ViceService();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final List<Vice> _vicesList = [];
  bool _isLoading = false;

  List<Vice> get vices => List.unmodifiable(_vicesList);
  bool get isLoading => _isLoading;

  // Carregar vices do banco de dados remoto e sincronizar com o banco local
  Future<List<Vice>> fetchVicesAndSync(String _bearerToken) async {
    _isLoading = true;
    try {
      // Carregar vices do banco remoto
      final fetchedVices = await _viceService.fetchVices(_bearerToken);

      // Limpar a lista local antes de adicionar os novos vices
      _vicesList.clear();
      _vicesList.addAll(fetchedVices);

      // Sincronizar com o banco SQLite local
      for (var vice in fetchedVices) {
        try {
          await _databaseHelper.insertVice(vice); // Insere cada vice no banco local
          print("Inserted vice: ${vice.toJson()}");
        } catch (e) {
          print("Error inserting vice into local database: $e");
        }
      }

      _isLoading = false;
      notifyListeners(); // Notifica os ouvintes (UI) sobre a atualização dos vices
      return fetchedVices;
    } catch (e) {
      print("Error fetching vices: $e");

      // Tentar carregar vices do banco local caso o carregamento do banco remoto falhe
      try {
        final localVices = await _databaseHelper.getAllVices();
        _vicesList.clear();
        _vicesList.addAll(localVices);
      } catch (e) {
        print("Error fetching all vices from local database: $e");
      }

      _isLoading = false;
      notifyListeners(); // Notifica a UI sobre a falha e tenta carregar os vices locais
      return _vicesList;
    }
  }

  // Método para adicionar um vice
  Future<void> addVice(Vice vice, String _bearerToken) async {
    _isLoading = true;
    try {
      await _viceService.addVice(vice, _bearerToken);
      _vicesList.add(vice);
      try {
        await _databaseHelper.insertVice(vice);
        print("Inserting vice: $vice");
      } catch (e) {
        print("Error inserting vice into local database: $e");
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      // Caso o envio para o servidor falhe, tenta inserir apenas no banco local
      try {
        await _databaseHelper.insertVice(vice);
        print("Inserting vice: $vice");
      } catch (e) {
        print("Error inserting vice into local database: $e");
      }
      print("Error adding vice: $e");
      _isLoading = false;
      notifyListeners();
    }
  }

  // Método para atualizar um vice
  Future<void> updateVice(Map<String, dynamic> vice, String _bearerToken) async {
    _isLoading = true;
    try {
      await _viceService.updateVice(vice, _bearerToken);
      final updatedVice = Vice.fromJson(vice);
      await _databaseHelper.updateVice(updatedVice);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print("Error updating vice: $e");
      _isLoading = false;
      notifyListeners();
    }
  }

  // Método para resetar o tempo de um vice
  Future<void> resetVice(String id, String _bearerToken) async {
    _isLoading = true;
    try {
      await _viceService.resetViceTime(id, _bearerToken);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print("Error updating vice: $e");
      _isLoading = false;
      notifyListeners();
    }
  }

  // Método para remover um vice
  Future<void> removeVice(Vice vice, String _bearerToken) async {
    _isLoading = true;
    try {
      await _viceService.removeVice(vice, _bearerToken);
      await _databaseHelper.deleteVice(vice.id);
      _vicesList.removeWhere((v) => v.id == vice.id);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print("Error removing vice: $e");
      _isLoading = false;
      notifyListeners();
    }
  }

  // Função para retornar o "avatar" ou título baseado no tempo de sobriedade
   String getAvatar() {
    if (_vicesList.isEmpty) return "Sem título";

    final now = DateTime.now();

    Vice viceWithMostSobriety = _vicesList[0];
    int maxSobrietyDays =
        now.difference(viceWithMostSobriety.datesobriety).inDays;

    for (final vice in _vicesList) {
      final sobrietyDays = now.difference(vice.datesobriety).inDays;

      if (sobrietyDays > maxSobrietyDays) {
        viceWithMostSobriety = vice;
        maxSobrietyDays = sobrietyDays;
      }
    }

    int sobrietyMonths = maxSobrietyDays ~/ 30;
    int sobrietyYears = maxSobrietyDays ~/ 365;

    if (sobrietyYears == 2) {
      return "Deus(a) da Disciplina";
    } else if (sobrietyYears == 1) {
      return "Titã do Foco";
    } else if (sobrietyMonths >= 9) {
      return "Guardião do Olimpo";
    } else if (sobrietyMonths >= 6) {
      return "Cavaleiro de Prata";
    } else if (sobrietyMonths >= 3) {
      return "Guerreiro de Bronze";
    } else if (sobrietyMonths >= 0) {
      return "Guerreiro recruta";
    } else {
      return "Imortal da Superação";
    }
  }

  List<TimeOfDay> getDangerousTimes() {
    List<TimeOfDay> allDangerousTimes = [];

    for (Vice vice in _vicesList) {
      if (vice.dangerousTimes != null) {
        allDangerousTimes.addAll(vice.dangerousTimes!);
      }
    }

    return allDangerousTimes;
  }
}