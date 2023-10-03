import 'package:flutter_test/flutter_test.dart';
import 'package:twp_dewitt_boxsley/url_builder.dart';

void main() {
  test('', () {
    final expectedUrl =
        'https://en.wikipedia.org/w/api.php?action=query&format=json&prop=revisions&titles=Computer&rvprop=timestamp|user&rvlimit=100&redirects';
    final pageName = 'Computer';
    final numberOfRevisions = 100;

    final urlBuilder = new UrlBuilder();
    final resultUrl = urlBuilder.buildUrl(pageName, numberOfRevisions);

    expect(resultUrl, expectedUrl);
  });
}
