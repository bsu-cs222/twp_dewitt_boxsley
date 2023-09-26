class UrlBuilder {
  String buildUrl(String input) {
    return 'https://en.wikipedia.org/w/api.php?action=query&format=json&prop=revisions&titles=' +
        input +
        '&rvprop=timestamp|user&rvlimit=4&redirects';
  }
}
