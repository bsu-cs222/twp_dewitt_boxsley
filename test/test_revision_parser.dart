import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:twp_dewitt_boxsley/revision.dart';
import 'package:twp_dewitt_boxsley/page_data_parser.dart';

void main() async {
  const pageName = 'Computer';
  const mostRecentEditor = 'HeyElliott';
  const timestamp = '2023-09-17T03:19:27Z';

  final expectedRevision = Revision(
    page: pageName,
    username: mostRecentEditor,
    timestamp: timestamp,
  );

  test('The last user to edit $pageName was $mostRecentEditor at $timestamp', () {
    final File file = File('test/test_data.json');
    final String string = file.readAsStringSync();

    final parser = PageDataParser(string);
    final wasRedirected = parser.wasRedirected();
    final Revision resultRevision = parser.getRevision(0);

    expect(resultRevision.page, expectedRevision.page);
    expect(resultRevision.username, expectedRevision.username);
    expect(resultRevision.timestamp, expectedRevision.timestamp);
    expect(wasRedirected, true);
  });
}
