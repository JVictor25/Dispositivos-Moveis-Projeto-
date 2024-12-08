import 'package:breakpoint_app/model/DiaryEntry.dart';
import 'package:breakpoint_app/model/User.dart';
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

const List<String> viceType = [
  'Geral',
  'Alcool',
  'Fumo',
  'Jogos de Azar',
  'Comida',
  'Drogas',
  'Tecnologia',
  'Trabalho',
  'Relacionamentos',
  'Redes Sociais',
  'Compras',
  'Séries e Filmes',
  'Exercício Excessivo',
  'Cafeína',
  'Apostas Esportivas',
  'Celular',
  'Internet',
  'Sono',
  'Estimulantes',
  'Jogos Online',
  'Apostas Financeiras',
  'Automedicação',
  'Moda e Aparência',
  'Doce',
];

List<User> userList = [
    User(
      id: '0',
      username: "Admin",
      email: "Admin@breakpoint.com",
      password: "123",
    ),
    User(
      id: '0',
      username: "Visitante",
      email: "Visitante@breakpoin.com",
      password: "000",
      )
  ];

List<String> emotions = ["Feliz", "Triste", "Raiva", "Ansioso", "Cansado"];

final Map<String, String> emotionEmojis = {
  "Feliz": "😊",
  "Triste": "😔",
  "Raiva": "😡",
  "Ansioso": "😖",
  "Cansado": "😩",
};

List<Vice> exampleVices = [
  Vice(
    datesobriety: DateTime.now(), 
    dateCreation: DateTime.now(),
    viceType: 'Fumo',
    /*impactType: 'money', // Exemplo de tipo de impacto
    impactValue: 50.0, // Exemplo de valor de impacto (R$)*/
  ),
  Vice(
    datesobriety: DateTime(2024, 9, 20),
    dateCreation: DateTime(2024, 10, 20),
    viceType: 'Alcool',
    /*impactType: 'money', // Tipo de impacto: tempo
    impactValue: 200,  // Exemplo de valor de impacto (R$)*/
  ),
  Vice(
    datesobriety: DateTime(2024, 1, 10),
    dateCreation: DateTime(2024, 4, 10),
    viceType: 'Jogos de Azar',
    /*impactType: 'money',
    impactValue: 100.0, // Exemplo de valor de impacto (R$)*/
  ),
  Vice(
    datesobriety: DateTime(2023, 8, 5),
    dateCreation: DateTime(2023, 10, 5),
    viceType: 'Comida',
    /*impactType: 'none',
    impactValue: null, // Exemplo de valor de impacto (horas perdidas por dia)*/
  ),
  Vice(
    datesobriety: DateTime(2022, 7, 1),
    dateCreation: DateTime(2022, 10, 1),
    viceType: 'Tecnologia',
    /*impactType: 'time', // Nenhum impacto calculável
    impactValue: 4, // Nenhum valor de impacto*/
  ),
];

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