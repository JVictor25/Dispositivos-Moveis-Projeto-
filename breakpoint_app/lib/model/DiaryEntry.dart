class DiaryEntry {

  DiaryEntry({required this.body, DateTime? date}): date = date ?? DateTime.now();

  String body;
  DateTime date;
}