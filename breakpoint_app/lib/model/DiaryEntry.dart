class DiaryEntry {

  DiaryEntry({required this.title, required this.text, required this.emotion, required this.createdAt});

  String title;
  String text;
  String emotion = '';
  DateTime createdAt;
}