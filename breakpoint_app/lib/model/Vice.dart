import 'package:uuid/uuid.dart';

class Vice {
  final String id;  // A chave única
  final DateTime datesobriety;
  final DateTime dateCreation;
  final String viceType;
  /*final String impactType;
  final dynamic impactValue;*/

  Vice({
    String? id,
    required this.datesobriety,
    required this.dateCreation,
    required this.viceType,
    /*required this.impactType,
    required this.impactValue,*/
  }) : id = id ?? Uuid().v4(); // Gera um id único se não for fornecido

  // Construtor para criar a partir de outro objeto `Vice`
  Vice.fromVice(Vice vice)
      : id = vice.id,
        datesobriety = vice.datesobriety,
        dateCreation = vice.dateCreation,
        viceType = vice.viceType;
        /*impactType = vice.impactType,
        impactValue = vice.impactValue;*/// Ainda não desenvolvido

  // Fábrica para criar a partir de um JSON
  factory Vice.fromJson(Map<String, dynamic> json) {
    return Vice(
      id: json['id'].toString(),
      datesobriety: DateTime.parse(json['updatedAt']).toLocal(),
      dateCreation: DateTime.parse(json['createdAt']).toLocal(),
      viceType: json['title']
      /*impactType: json['impactType'],
      impactValue: json['impactValue'],*/ //Ainda não desenvolvido
    );
  }

  // Serialização para JSON
  Map<String, dynamic> toJson() {
    return {
      'title': viceType,
      //'title': viceType,
      /*'impactType': impactType,
      'impactValue': impactValue,*/ // Ainda não desenvolvido
    };
  }

  // Método copyWith
  Vice copyWith({
    String? id,
    String? typeofvice,
    DateTime? datesobriety,
    String? viceType,
    /*String? impactType,
    dynamic impactValue,*/// Ainda não desenvolvido
  }) {
    return Vice(
      id: id ?? this.id,  // Mantém a chave existente ou substitui
      datesobriety: datesobriety ?? this.datesobriety,
      dateCreation: this.dateCreation, // Não modifica a data de criação
      viceType: viceType ?? this.viceType,
      /*impactType: impactType ?? this.impactType,
      impactValue: impactValue ?? this.impactValue,*/// Ainda não desenvolvido
    );
  }
}
