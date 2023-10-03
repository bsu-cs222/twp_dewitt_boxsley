class UrlBuilder {
  String buildUrl(String pageName, int numberOfRevisions) {
    return 'https://en.wikipedia.org/w/api.php?action=query&format=json&prop=revisions&titles=$pageName&rvprop=timestamp|user&rvlimit=${numberOfRevisions.toString()}&redirects';
  }
}
