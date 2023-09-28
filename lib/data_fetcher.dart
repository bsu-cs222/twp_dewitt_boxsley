import 'package:http/http.dart' as http;

class DataFetcher {
  Future<String> fetchData(String input) async {
    final uri = Uri.parse(input);

    final result = await http.read(uri, headers: {
      'user-agent':
          'Revision Reporter/0.1 (http://www.cs.bsu.edu/~pvgestwicki/courses/cs222Fa23; wesley.dewitt@bsu.edu)'
    });

    return (result.toString());
  }
}
