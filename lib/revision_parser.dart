import 'revision.dart';

class RevisionParser {
  Revision getRevision(Map inputJson, int index) {
    final pageId =
        inputJson['query']['pages'].values.elementAt(0)['pageid'].toString();
    final pageName = inputJson['query']['pages'][pageId]['title'];
    final mostRecentEditor = inputJson['query']['pages'][pageId]['revisions']
            [index]
        .values
        .elementAt(0);
    final timestamp = inputJson['query']['pages'][pageId]['revisions'][index]
        .values
        .elementAt(1);

    return Revision(
      page: pageName,
      username: mostRecentEditor,
      timestamp: timestamp,
    );
  }

  bool wasRedirected(Map inputJson) {
    if (inputJson['query'].keys.elementAt(1).toString() == 'redirects') {
      return true;
    } else {
      return false;
    }
  }
}
