class Vice {
  Vice({
    required this.typeofvice,
    required this.datesobriety,
    required this.viceType,
    required this.dateCreation,
    required this.impactType, // Tipo de impacto
    this.impactValue, // Valor do impacto (opcional)
  });

  String typeofvice; // Título do vício
  DateTime datesobriety; // Data definida pelo usuário
  DateTime dateCreation; // Data que foi criado
  String viceType; // Tipo de vício (geral ou específico)
  String impactType; // Tipo de impacto: dinheiro, tempo ou outro
  dynamic impactValue; // Valor do impacto: dinheiro (double), tempo (int em horas), ou null
}