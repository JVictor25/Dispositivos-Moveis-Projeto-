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
    required this.reseted
  }) : id = id ?? Uuid().v4();


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

  factory Vice.fromJson(Map<String, dynamic> json) {
    return Vice(
      id: json['id'].toString(),
      datesobriety: DateTime.parse(json['updatedAt']).toLocal(),
      dateCreation: DateTime.parse(json['createdAt']).toLocal(),
      viceType: json['title'],
      impactType: json['addictionImpact'] ?? '',
      impactValue: json['impactCost'] ?? '',
      description: json['description'] ?? '',
      dangerousTimes: (json['criticalHours'] as List<dynamic>?)
          ?.map((timeString) {
            final parts = (timeString as String).split(':');
            return TimeOfDay(
              hour: int.parse(parts[0]),
              minute: int.parse(parts[1]),
            );
          }).toList() ?? [],
          reseted: json['reseted'],
    );
  }

  Map<String, dynamic> toJson() {
  return {
    'description': description,
    'addictionImpact': impactType,
    'impactCost': impactValue,
    'criticalHours': dangerousTimes?.map((time) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    }).toList(),
  };
}



Map<String, dynamic> toJsonAdd() {
  return {
    'title': viceType,
    'description': description,
    'addictionImpact': impactType,
    'impactCost': impactValue,
    'criticalHours': dangerousTimes?.map((time) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    }).toList(),
  };
}

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
      reseted: reseted ?? this.reseted 
    );
  }
}
