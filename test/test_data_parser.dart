import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:twp_dewitt_boxsley/utilities/data_parser.dart';
import 'package:twp_dewitt_boxsley/utilities/revision.dart';

void main() async {
  test('', () {
    final File file = File('test/test_data.json');
    final String string = file.readAsStringSync();

    const pageName = 'Computer';
    const mostRecentEditor = 'HeyElliott';
    final timestamp = DateTime.parse('2023-09-17T03:19:27Z').toString();

    final expectedRevision = Revision(
      page: pageName,
      username: mostRecentEditor,
      timestamp: timestamp,
    );

    final parser = DataParser(string);
    final wasRedirected = parser.wasRedirected();
    final Revision resultRevision = parser.getRevision(0);

    expect(resultRevision.page, expectedRevision.page);
    expect(resultRevision.username, expectedRevision.username);
    expect(resultRevision.timestamp, expectedRevision.timestamp);
    expect(wasRedirected, true);
  });
}
