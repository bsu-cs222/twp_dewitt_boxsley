import 'package:flutter_test/flutter_test.dart';
import 'package:twp_dewitt_boxsley/data_fetcher.dart';

void main() {
  test('', () async {
    const input =
        'https://en.wikipedia.org/w/api.php?action=query&format=json&prop=revisions&titles=Computer&rvprop=timestamp|user&rvlimit=4&redirects';
    DataFetcher dataFetcher = DataFetcher();
    final data = await dataFetcher.fetchData(input);
    print(data);
  });
}
