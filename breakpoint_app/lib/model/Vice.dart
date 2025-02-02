import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Vice {
  final String id;
  DateTime datesobriety;
  final DateTime? dateCreation;
  final String viceType;
  final String impactType;
  final String? impactValue;
  List<TimeOfDay>? dangerousTimes;
  final String description;
  bool reseted;

  Vice({
    String? id,
    required this.datesobriety,
    this.dateCreation,
    required this.viceType,
    required this.impactType,
    this.impactValue,
    this.dangerousTimes,
    required this.description,
    required this.reseted,
  }) : id = id ?? Uuid().v4();

  // Construtor de cópia de um vice
  Vice.fromVice(Vice vice)
      : id = vice.id,
        datesobriety = vice.datesobriety,
        dateCreation = vice.dateCreation,
        viceType = vice.viceType,
        impactType = vice.impactType,
        impactValue = vice.impactValue,
        dangerousTimes = vice.dangerousTimes,
        description = vice.description,
        reseted = vice.reseted;

  // Factory para criar um vice a partir de um JSON
  factory Vice.fromJson(Map<String, dynamic> json) {
    return Vice(
      id: json['id'].toString(),
      datesobriety: DateTime.parse(json['updatedAt']).toLocal(),
      dateCreation: DateTime.parse(json['createdAt']).toLocal(),
      viceType: json['title'],
      impactType: json['addictionImpact'] ?? '',
      impactValue: json['impactCost'] ?? '',
      description: json['description'] ?? '',
      dangerousTimes:
          (json['criticalHours'] as List<dynamic>?)?.map((timeString) {
                final parts = (timeString as String).split(':');
                return TimeOfDay(
                  hour: int.parse(parts[0]),
                  minute: int.parse(parts[1]),
                );
              }).toList() ??
              [],
      reseted: json['reseted'],
    );
  }

  // Converte a instância do vice em JSON para salvar no banco
  // Converte a instância do vice em JSON para salvar no banco
  Map<String, dynamic> toJson() {
    return {
      'id': id, // Inclui o ID do vice
      'user_id': '', // Insira o ID do usuário, se necessário
      'datesobriety':
          datesobriety.toIso8601String(), // Converte para string de data
      'dateCreation':
          dateCreation?.toIso8601String() ?? '', // Converte a data de criação
      'viceType': viceType, // Tipo do vício (viceType)
      'impactType': impactType, // Tipo de impacto do vício (impactType)
      'impactValue':
          impactValue ?? '', // Valor do impacto, caso haja (impactValue)
      'description': description, // Descrição do vício
      'reseted': reseted
          ? 1
          : 0, // Define como 1 (true) ou 0 (false) para o banco de dados
      'impactCost': impactValue ??
          '', // Como você mencionou, é impactCost no banco de dados, pode ser o mesmo que impactValue
    };
  }

  // Método adicional para adicionar um novo vice (com title ao invés de viceType)
  Map<String, dynamic> toJsonAdd() {
    return {
      'title': viceType,
      'description': description,
      'addictionImpact': impactType,
      'impactCost': impactValue,
    };
  }

  // Método de cópia para facilitar a atualização dos vices
  Vice copyWith({
    String? id,
    String? typeofvice,
    DateTime? datesobriety,
    String? viceType,
    String? impactType,
    String? impactValue,
    List<TimeOfDay>? dangerousTime,
    String? descricao,
    bool? reseted,
  }) {
    return Vice(
      id: id ?? this.id,
      datesobriety: datesobriety ?? this.datesobriety,
      dateCreation: this.dateCreation,
      viceType: viceType ?? this.viceType,
      impactType: impactType ?? this.impactType,
      impactValue: impactValue ?? this.impactValue,
      dangerousTimes: dangerousTime ?? this.dangerousTimes,
      description: descricao ?? this.description,
      reseted: reseted ?? this.reseted,
    );
  }
}
