import 'package:flutter/cupertino.dart';
import 'package:twp_dewitt_boxsley/screens/home_screen.dart';

class ListItem extends StatefulWidget {
  const ListItem({
    super.key,
    required this.userName,
    required this.timestamp,
  });

  final String userName;
  final DateTime timestamp;

  @override
  State<ListItem> createState() => _ListItem();
}

class _ListItem extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
      child: SizedBox(
        width: containerWidth,
        child: Text(
          '- ${widget.userName} @ ${widget.timestamp.toIso8601String()}',
        ),
      ),
    );
  }
}
