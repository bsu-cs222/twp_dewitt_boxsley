import 'package:flutter/cupertino.dart';

class ListItem extends StatefulWidget {
  const ListItem({
    super.key,
    this.userName = '',
    this.timestamp = '',
  });

  final String userName;
  final String timestamp;

  @override
  State<ListItem> createState() => _ListItem();
}

class _ListItem extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
      child: Row(
        children: [
          Text(
            '- ${widget.userName}',
          ),
          Text(
            ' @ ${widget.timestamp}',
          ),
        ],
      ),
    );
  }
}
