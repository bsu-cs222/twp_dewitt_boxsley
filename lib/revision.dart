class Revision {
  String page = '';
  String username = '';
  DateTime timestamp = DateTime.utc(0);

  Revision({
    required String page,
    required String username,
    required DateTime timestamp,
  }) {
    this.page = page;
    this.username = username;
    this.timestamp = timestamp;
  }
}
