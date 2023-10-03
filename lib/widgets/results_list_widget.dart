import 'package:flutter/cupertino.dart';

import '../main.dart';
import 'list_item_widget.dart';

class ResultsListWidget extends StatefulWidget {
  const ResultsListWidget({
    super.key,
    this.pageName = '',
    this.resultsList = const [],
  });

  final String pageName;
  final List<ListItem> resultsList;

  @override
  State<ResultsListWidget> createState() => _ResultsListWidget();
}

class _ResultsListWidget extends State<ResultsListWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 64, 0, 64),
      child: Column(
        children: [
          SizedBox(
            width: containerWidth,
            child: widget.resultsList.isNotEmpty ? Text('The Wikipedia page ${widget.pageName} was edited by:') : null,
          ),
          Column(
            children: [
              for (int i = 0; i < widget.resultsList.length; i++) widget.resultsList[i],
            ],
          )
        ],
      ),
    );
  }
}
