import 'dart:convert';

import 'revision.dart';

class DataParser {
  Map decodedJson = {};

  DataParser(String inputJson) {
    decodedJson = jsonDecode(inputJson);
  }

  int getNumberOfRevisions() {
    final pageId = decodedJson['query']['pages'].keys.first;
    return decodedJson['query']['pages'][pageId]['revisions'].length;
  }

  Revision getRevision(int index) {
    final pageId = decodedJson['query']['pages'].keys.first;
    final pageName = decodedJson['query']['pages'][pageId]['title'];
    final editor = decodedJson['query']['pages'][pageId]['revisions'][index]['user'];
    final timestampString = decodedJson['query']['pages'][pageId]['revisions'][index]['timestamp'];
    final timestamp = DateTime.parse(timestampString);

    return Revision(
      page: pageName,
      userName: editor,
      timestamp: timestamp,
    );
  }

  String getPageName() {
    final pageId = decodedJson['query']['pages'].keys.first;
    return decodedJson['query']['pages'][pageId]['title'];
  }

  bool pageExists() {
    if (decodedJson['query']['pages'].containsKey('-1')) {
      return false;
    } else {
      return true;
    }
  }

  bool wasRedirected() {
    if (decodedJson['query'].containsKey('redirects')) {
      return true;
    } else {
      return false;
    }
  }
}
