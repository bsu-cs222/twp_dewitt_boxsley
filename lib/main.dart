import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const containerWidth = 600.0;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Column(
      children: [
        SizedBox(
          width: containerWidth,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
            child: Text(
              'Wikipedia Revision Search',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          width: containerWidth,
          child: Text(
            'A tool for analyzing revisions made to Wikipedia pages',
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
        ),
      ],
    );

    return MaterialApp(
      title: 'Wikipedia Revision Search',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Align(
          alignment: Alignment(0.0, -1.0),
          child: Container(
            width: containerWidth + 64 * 2,
            padding: const EdgeInsets.all(64),
            child: ListView(
              children: [
                titleSection,
                UserInputWidget(),
                SearchRedirectNoticeWidget(),
                ResultsListWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserInputWidget extends StatefulWidget {
  @override
  State<UserInputWidget> createState() => _UserInputWidgetState();
}

class _UserInputWidgetState extends State<UserInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 64, 8, 0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Wikipedia page name',
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 64, 0, 0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Number of revisions',
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Search for revisions'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SearchRedirectNoticeWidget extends StatefulWidget {
  @override
  State<SearchRedirectNoticeWidget> createState() => _SearchRedirectNoticeWidget();
}

class _SearchRedirectNoticeWidget extends State<SearchRedirectNoticeWidget> {
  final userSearchTerm = 'Copmuter';
  final redirectedSearchTerm = 'Computer';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 64, 0, 0),
      child: Text(
        'Your search was redirected from "$userSearchTerm" to $redirectedSearchTerm',
        //textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.grey[500],
        ),
      ),
    );
  }
}

class ResultsListWidget extends StatefulWidget {
  @override
  State<ResultsListWidget> createState() => _ResultsListWidget();
}

class _ResultsListWidget extends State<ResultsListWidget> {
  final userSearchTerm = 'Copmuter';
  final redirectedSearchTerm = 'Computer';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 64, 0, 64),
      child: Column(
        children: [
          SizedBox(
            width: containerWidth,
            child: Text(
              'The Wikipedia page $redirectedSearchTerm was edited by:',
            ),
          ),
          ListItem(),
          ListItem(),
          ListItem(),
        ],
      ),
    );
  }
}

class ListItem extends StatefulWidget {
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
            'ThisIsAUsername at ',
            style: TextStyle(
                //fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            'This is a timestamp',
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
