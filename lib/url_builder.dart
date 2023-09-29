class UrlBuilder {
  String buildUrl(String input) {
    String beginning = 'https://en.wikipedia.org/w/api.php?action=query&format=json&prop=revisions&titles=';
    String end = '&rvprop=timestamp|user&rvlimit=4&redirects';

    return beginning + input + end;
  }
}
