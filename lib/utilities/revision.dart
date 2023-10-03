class Revision {
  String page = '';
  String userName = '';
  DateTime timestamp = DateTime.utc(0);

  Revision({
    required this.page,
    required this.userName,
    required this.timestamp,
  });
}
