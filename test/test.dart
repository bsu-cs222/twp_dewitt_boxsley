import 'package:test/test.dart';

void main() {
  final data = <String, String>{};

  for (final entry in data.entries) {
    final pageName = entry.key;
    final mostRecentEditor = entry.value;

    test('The last user to edit the $pageName page is $mostRecentEditor', () {
      final calculator = LetterGradeCalculator();
      String result = calculator.calculateLetterGrade(numericGrade);
      expect(result, letterGrade);
    });
  }
}
