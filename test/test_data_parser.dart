import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:twp_dewitt_boxsley/utilities/data_parser.dart';
import 'package:twp_dewitt_boxsley/utilities/revision.dart';

void main() async {
  test('', () {
    final File file = File('test/test_data.json');
    final String string = file.readAsStringSync();

    const String pageName = 'Computer';
    const String mostRecentEditor = 'HeyElliott';
    final DateTime timestamp = DateTime.parse('2023-09-17T03:19:27Z');

    final expectedRevision = Revision(
      page: pageName,
      userName: mostRecentEditor,
      timestamp: timestamp,
    );

    final parser = DataParser(string);
    final wasRedirected = parser.wasRedirected();
    final Revision resultRevision = parser.getRevision(0);
    print(parser.getNumberOfRevisions());

    expect(resultRevision.page, expectedRevision.page);
    expect(resultRevision.userName, expectedRevision.userName);
    expect(resultRevision.timestamp, expectedRevision.timestamp);
    expect(wasRedirected, true);
  });
}
