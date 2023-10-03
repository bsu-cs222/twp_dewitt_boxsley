class Revision {
  String page = '';
  String username = '';
  String timestamp = DateTime.utc(0).toString();

  Revision({
    required String page,
    required String username,
    required String timestamp,
  }) {
    this.page = page;
    this.username = username;
    this.timestamp = timestamp;
  }
}
