import 'package:flutter_test/flutter_test.dart';
import 'package:twp_dewitt_boxsley/utilities/url_builder.dart';

void main() {
  test('', () {
    const expectedUrl =
        'https://en.wikipedia.org/w/api.php?action=query&format=json&prop=revisions&titles=Computer&rvprop=timestamp|user&rvlimit=100&redirects';
    const pageName = 'Computer';
    const numberOfRevisions = 100;

    final urlBuilder = UrlBuilder();
    final resultUrl = urlBuilder.buildUrl(pageName, numberOfRevisions);

    expect(resultUrl, expectedUrl);
  });
}
