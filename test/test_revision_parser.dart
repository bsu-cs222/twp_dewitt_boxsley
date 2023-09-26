import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:twp_dewitt_boxsley/revision.dart';
import 'package:twp_dewitt_boxsley/revision_parser.dart';

void main() async {
  Future<Map> readJsonFile(String filePath) async {
    var input = await File(filePath).readAsString();
    var map = jsonDecode(input);
    return map;
  }

  final data = await readJsonFile('test/testdata.json');
  const pageName = 'Computer';
  const mostRecentEditor = 'HeyElliott';
  const timestamp = '2023-09-17T03:19:27Z';

  final revision = Revision(
    page: pageName,
    username: mostRecentEditor,
    timestamp: timestamp,
  );

  test(
      'The last user to edit the $pageName page is $mostRecentEditor at $timestamp',
      () {
    final parser = RevisionParser();
    final wasRedirected = parser.wasRedirected(data);
    Revision resultRevision = parser.getRevision(data, 0);

    expect(resultRevision.page, revision.page);
    expect(resultRevision.username, revision.username);
    expect(resultRevision.timestamp, revision.timestamp);
    expect(wasRedirected, true);
  });
}
