class Vice {
  Vice({
    required this.typeofvice,
    required this.datesobriety,
    required this.viceType,
    required this.dateCreation
  });

  String typeofvice; // Título do vício
  DateTime datesobriety; // Data definida pelo usuário
  DateTime dateCreation; // Data que foi criado
  String viceType; // Tipo de vício (geral ou específico)
}
