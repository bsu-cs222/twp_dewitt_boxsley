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
    print(inputJson['query'].keys.elementAt(1).toString());
    String expectedText = inputJson['query'].keys.elementAt(1).toString();
    if (expectedText == 'redirects') {
      return true;
    } else {
      return false;
    }
  }
}
