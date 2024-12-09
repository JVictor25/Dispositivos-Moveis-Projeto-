import 'package:breakpoint_app/providers/vice_service.dart';
import 'package:flutter/foundation.dart';
import 'package:breakpoint_app/model/Vice.dart';

class ViceProvider with ChangeNotifier {
  final ViceService _viceService = ViceService();
  final List<Vice> _vicesList = [];
  bool _isLoading = false;

  List<Vice> get vices => List.unmodifiable(_vicesList);
  bool get isLoading => _isLoading;

  Future<List<Vice>> fetchVices(String _bearerToken) async {
    _isLoading = true;
    try {
      final fetchedVices = await _viceService.fetchVices(_bearerToken);
      _vicesList.clear();
      _vicesList.addAll(fetchedVices);
      _isLoading = false;
      notifyListeners();
      return fetchedVices;
    } catch (e) {
      print("Error fetching vices: $e");
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> addVice(Vice vice, String _bearerToken) async {
    _isLoading = true;
    try {
      await _viceService.addVice(vice, _bearerToken);
      _vicesList.add(vice);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print("Error adding vice: $e");
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> updateVice(Vice updatedVice, String _bearerToken) async {
    _isLoading = true;
    try {
      await _viceService.updateVice(updatedVice, _bearerToken);
      int index = _vicesList.indexWhere((vice) => vice.id == updatedVice.id);
      if (index != -1) {
        _vicesList[index] = updatedVice;
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print("Error updating vice: $e");
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> removeVice(Vice vice, String _bearerToken) async {
    _isLoading = true;
    try {
      await _viceService.removeVice(vice, _bearerToken);
      _vicesList.removeWhere((v) => v.id == vice.id);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print("Error removing vice: $e");
      _isLoading = false;
      notifyListeners();
    }
  }
}
