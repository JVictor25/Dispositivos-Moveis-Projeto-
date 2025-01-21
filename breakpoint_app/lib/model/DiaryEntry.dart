class DiaryEntry {

  DiaryEntry({this.id,  required this.title, required this.text, required this.emotion, required this.createdAt, this.image});

  int? id;
  String title;
  String text;
  String emotion = '';
  DateTime createdAt;
  String? image;

  factory DiaryEntry.fromJson(Map<String, dynamic> json) {
    return DiaryEntry(
      id: json['id'],
      title: json['title'],
      text: json['text'],
      emotion: json['emotion'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'text': text,
      'emotion': emotion,
    };
  }
  factory DiaryEntry.fromSQLite(Map<String, dynamic> map) {
    return DiaryEntry(
      id: map['id'],
      title: map['title'],
      text: map['text'],
      emotion: map['emotion'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Map<String, dynamic> toSQLite() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'emotion': emotion,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

