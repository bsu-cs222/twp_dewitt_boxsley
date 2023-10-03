import 'package:flutter/material.dart';
import 'package:twp_dewitt_boxsley/data_fetcher.dart';
import 'package:twp_dewitt_boxsley/data_parser.dart';
import 'package:twp_dewitt_boxsley/revision.dart';
import 'package:twp_dewitt_boxsley/url_builder.dart';

const containerWidth = 600.0;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ResultsListWidget resultsList = const ResultsListWidget();
  SearchRedirectNoticeWidget searchRedirectNoticeWidget = const SearchRedirectNoticeWidget();

  void updateResultsListWidget(ResultsListWidget newResultsListWidget) {
    setState(() {
      resultsList = newResultsListWidget;
    });
  }

  void updateSearchRedirectNoticeWidget(SearchRedirectNoticeWidget newSearchRedirectNoticeWidget) {
    setState(() {
      searchRedirectNoticeWidget = newSearchRedirectNoticeWidget;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Column(
      children: [
        const SizedBox(
          width: containerWidth,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 8.0),
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
          alignment: const Alignment(0.0, -1.0),
          child: Container(
            width: containerWidth + 64 * 2,
            padding: const EdgeInsets.all(64),
            child: ListView(
              children: [
                titleSection,
                UserInputWidget(
                  resultsListWidgetCallback: (val) => setState(() => resultsList = val),
                  searchRedirectNoticeWidgetCallback: (val) => setState(() => searchRedirectNoticeWidget = val),
                ),
                searchRedirectNoticeWidget,
                resultsList
              ],
            ),
          ),
        ),
      ),
    );
  }
}

typedef ResultsListWidgetCallback = void Function(ResultsListWidget val);
typedef SearchRedirectNoticeWidgetCallback = void Function(SearchRedirectNoticeWidget val);

class UserInputWidget extends StatefulWidget {
  final ResultsListWidgetCallback resultsListWidgetCallback;
  final SearchRedirectNoticeWidgetCallback searchRedirectNoticeWidgetCallback;

  const UserInputWidget({
    super.key,
    required this.resultsListWidgetCallback,
    required this.searchRedirectNoticeWidgetCallback,
  });

  @override
  State<UserInputWidget> createState() => _UserInputWidgetState();
}

class _UserInputWidgetState extends State<UserInputWidget> {
  List<ListItem> revisionsList = <ListItem>[];

  final pageNameController = TextEditingController();
  final numberOfRevisionsController = TextEditingController();

  handleSearchButtonPress() async {
    revisionsList = [];

    final userSearchTerm = pageNameController.text;
    final numberOfRevisions = int.parse(numberOfRevisionsController.text);

    UrlBuilder urlBuilder = UrlBuilder();
    final String url = urlBuilder.buildUrl(userSearchTerm, numberOfRevisions);

    DataFetcher dataFetcher = DataFetcher();
    final String jsonData = await dataFetcher.fetchData(url);

    DataParser dataParser = DataParser(jsonData);
    final wasRedirected = dataParser.wasRedirected();
    final pageName = dataParser.getPageName();

    widget.searchRedirectNoticeWidgetCallback(SearchRedirectNoticeWidget(
      wasRedirected: wasRedirected,
      userSearchTerm: userSearchTerm,
      redirectedSearchTerm: pageName,
    ));

    for (int i = 0; i < numberOfRevisions; i++) {
      Revision revision = dataParser.getRevision(i);
      revisionsList.add(ListItem(
        userName: revision.username,
        timestamp: revision.timestamp,
      ));
    }

    widget.resultsListWidgetCallback(ResultsListWidget(
      pageName: pageName,
      resultsList: revisionsList,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 64, 8, 0),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Wikipedia page name',
                  ),
                  controller: pageNameController,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 64, 0, 0),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Number of revisions',
                  ),
                  controller: numberOfRevisionsController,
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
                onPressed: () {
                  handleSearchButtonPress();
                },
                child: const Text('Search for revisions'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SearchRedirectNoticeWidget extends StatefulWidget {
  const SearchRedirectNoticeWidget({
    super.key,
    this.wasRedirected = false,
    this.userSearchTerm = '',
    this.redirectedSearchTerm = '',
  });

  final bool wasRedirected;
  final String userSearchTerm;
  final String redirectedSearchTerm;

  @override
  State<SearchRedirectNoticeWidget> createState() => _SearchRedirectNoticeWidget();
}

class _SearchRedirectNoticeWidget extends State<SearchRedirectNoticeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.wasRedirected
          ? Padding(
              padding: const EdgeInsets.fromLTRB(0, 64, 0, 0),
              child: Text('Your search was redirected from "${widget.userSearchTerm}" to ${widget.redirectedSearchTerm}.'),
            )
          : null,
    );
  }
}

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
