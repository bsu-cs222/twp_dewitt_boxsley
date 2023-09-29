import 'dart:convert';

import 'revision.dart';

class PageDataParser {
  Map decodedJson = {};

  PageDataParser(String inputJson) {
    this.decodedJson = jsonDecode(inputJson);
  }

  Revision getRevision(int index) {
    final pageId = decodedJson['query']['pages'].keys.first;
    final pageName = decodedJson['query']['pages'][pageId]['title'];
    final editor = decodedJson['query']['pages'][pageId]['revisions'][index]['user'];
    final timestampString = decodedJson['query']['pages'][pageId]['revisions'][index]['timestamp'];

    return Revision(
      page: pageName,
      username: editor,
      timestamp: timestampString,
    );
  }

  bool wasRedirected() {
    if (decodedJson['query'].keys.elementAt(1) == 'redirects') {
      return true;
    } else {
      return false;
    }
  }
}
