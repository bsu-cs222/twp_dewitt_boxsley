import 'package:flutter_test/flutter_test.dart';
import 'package:twp_dewitt_boxsley/url_builder.dart';

final expectedUrl =
    'https://en.wikipedia.org/w/api.php?action=query&format=json&prop=revisions&titles=Computer&rvprop=timestamp|user&rvlimit=4&redirects';
final input = 'Computer';

void main() {
  test('', () {
    final urlBuilder = new UrlBuilder();
    final resultUrl = urlBuilder.buildUrl(input);

    expect(resultUrl, expectedUrl);
  });
}
