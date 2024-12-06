import 'package:uuid/uuid.dart';

class Vice {
  final String id;  // A chave única
  final String typeofvice;
  final DateTime datesobriety;
  final DateTime dateCreation;
  final String viceType;
  final String impactType;
  final dynamic impactValue;

  Vice({
    String? id,
    required this.typeofvice,
    required this.datesobriety,
    required this.dateCreation,
    required this.viceType,
    required this.impactType,
    required this.impactValue,
  }) : id = id ?? Uuid().v4(); // Gera um id único se não for fornecido

  // Método copyWith
  Vice copyWith({
    String? id,
    String? typeofvice,
    DateTime? datesobriety,
    String? viceType,
    String? impactType,
    dynamic impactValue,
  }) {
    return Vice(
      id: id ?? this.id,  // Mantém a chave existente ou substitui
      typeofvice: typeofvice ?? this.typeofvice,
      datesobriety: datesobriety ?? this.datesobriety,
      dateCreation: this.dateCreation, // Não modifica a data de criação
      viceType: viceType ?? this.viceType,
      impactType: impactType ?? this.impactType,
      impactValue: impactValue ?? this.impactValue,
    );
  }
}
