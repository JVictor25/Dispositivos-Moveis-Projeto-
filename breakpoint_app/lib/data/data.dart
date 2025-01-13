import 'package:breakpoint_app/model/DiaryEntry.dart';
import 'package:breakpoint_app/model/Vice.dart';
import 'package:flutter/material.dart';

const Map<String, IconData> iconMap = {
  'geral': Icons.add_box,
  'alcool': Icons.local_bar,
  'fumo': Icons.smoke_free_outlined,
  'jogos de azar': Icons.casino,
  'comida': Icons.restaurant,
  'drogas': Icons.local_pharmacy,
  'tecnologia': Icons.computer,
  'trabalho': Icons.work,
  'relacionamentos': Icons.person,
  'redes sociais': Icons.phone_android,
  'compras': Icons.shopping_cart,
  'séries e filmes': Icons.tv,
  'cafeína': Icons.coffee,
  'apostas esportivas': Icons.sports_soccer,
  'celular': Icons.smartphone,
  'internet': Icons.wifi,
  'sono': Icons.bedtime,
  'estimulantes': Icons.local_drink,
  'jogos online': Icons.sports_esports,
  'apostas financeiras': Icons.attach_money,
  'automedicação': Icons.healing,
  'moda e aparência': Icons.style,
  'doce': Icons.cake,
};

final Map<String, String> imageMap = {
  'Guerreiro recruta': 'assets/images/villager.png',
  'Guerreiro de Bronze': 'assets/images/bronze.png',
  'Cavaleiro de Prata': 'assets/images/prata.png',
  'Guardião do Olimpo': 'assets/images/guardião.png',
  'Titã do Foco': 'assets/images/titan.png',
  'Deus(a) da Disciplina': 'assets/images/Deus.png',
  'Imortal da Superação': 'assets/images/imortal.png'
};

const List<String> viceType = [
  'geral',
  'alcool',
  'fumo',
  'jogos de azar',
  'comida',
  'drogas',
  'tecnologia',
  'trabalho',
  'relacionamentos',
  'redes sociais',
  'compras',
  'series e filmes',
  'exercicio excessivo',
  'cafeina',
  'apostas esportivas',
  'celular',
  'internet',
  'sono',
  'estimulantes',
  'jogos online',
  'apostas financeiras',
  'automedicacao',
  'moda e aparencia',
  'doce',
];

List<String> emotions = ["Feliz", "Triste", "Raiva", "Ansioso", "Cansado"];

final Map<String, String> emotionEmojis = {
  "Feliz": "😊",
  "Triste": "😔",
  "Raiva": "😡",
  "Ansioso": "😖",
  "Cansado": "😩",
};

// (NOTE): Lembrar de remover o mockData depois
/*List<Vice> exampleVices = [
  Vice(
      datesobriety: DateTime.now(),
      dateCreation: DateTime.now(),
      viceType: 'Fumo',
      impactType: 'money',
      impactValue: "50.0",
      description: ""),
  Vice(
      datesobriety: DateTime(2024, 9, 20),
      dateCreation: DateTime(2024, 10, 20),
      viceType: 'Alcool',
      impactType: 'money',
      impactValue: "200",
      description: ""),
  Vice(
      datesobriety: DateTime(2024, 1, 10),
      dateCreation: DateTime(2024, 4, 10),
      viceType: 'Jogos de Azar',
      impactType: 'money',
      impactValue: "100.0",
      description: ""),
  Vice(
      datesobriety: DateTime(2023, 8, 5),
      dateCreation: DateTime(2023, 10, 5),
      viceType: 'Comida',
      impactType: 'none',
      impactValue: null,
      description: ""),
  Vice(
      datesobriety: DateTime(2022, 7, 1),
      dateCreation: DateTime(2022, 10, 1),
      viceType: 'Tecnologia',
      impactType: 'time',
      impactValue: "4",
      description: ""),
];*/

// (NOTE): Lembrar de remover o mockData depois
final List<DiaryEntry> mockData = [
  DiaryEntry(
    title: "Diário de Bordo",
    createdAt: DateTime(2021, 11, 1),
    emotion: "Feliz",
    text: "Hoje foi um dia muito bom!",
  ),
  DiaryEntry(
    title: "Diário de Bordo",
    createdAt: DateTime(2024, 5, 2),
    emotion: "Triste",
    text: "Hoje foi um dia muito ruim!",
  ),
  DiaryEntry(
    title: "Diário de Bordo",
    createdAt: DateTime(2024, 11, 3),
    emotion: "Raiva",
    text: "Hoje foi um dia muito irritante!",
  ),
  DiaryEntry(
    title: "Diário de Bordo",
    createdAt: DateTime(2024, 11, 4),
    emotion: "Ansioso",
    text: "Hoje foi um dia muito estressante!",
  ),
];
