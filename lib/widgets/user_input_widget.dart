import 'package:flutter/material.dart';
import 'package:twp_dewitt_boxsley/widgets/results_list_widget.dart';
import 'package:twp_dewitt_boxsley/widgets/search_redirect_notice_widget.dart';

import '../utilities/data_fetcher.dart';
import '../utilities/data_parser.dart';
import '../utilities/revision.dart';
import '../utilities/url_builder.dart';
import 'list_item_widget.dart';

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

  bool isLoading = false;

  setIsLoading(bool state) => setState(() => isLoading = state);

  handleSearchButtonPress() async {
    revisionsList = [];
    String jsonData = '';

    final userSearchTerm = pageNameController.text;
    final numberOfRevisions = int.parse(numberOfRevisionsController.text);

    UrlBuilder urlBuilder = UrlBuilder();
    final String url = urlBuilder.buildUrl(userSearchTerm, numberOfRevisions);

    DataFetcher dataFetcher = DataFetcher();
    try {
      setIsLoading(true);
      jsonData = await dataFetcher.fetchData(url);
    } catch (e) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Network Error'),
            content: const Text('Check your network connection and try again.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        return;
      }
    } finally {
      setIsLoading(false);
    }

    DataParser dataParser = DataParser(jsonData);
    final pageExists = dataParser.pageExists();
    final wasRedirected = dataParser.wasRedirected();
    final pageName = dataParser.getPageName();

    if (numberOfRevisions > 500) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Exceeded maximum revisions'),
            content: const Text('The maximum number of revisions to show is 500.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } else if (pageExists) {
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
    } else {
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('No such page'),
            content:
                Text('The Wikipedia page for "$userSearchTerm" cannot be found. Try checking your spelling or entering a different search term.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
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
                  enabled: !isLoading,
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
                  enabled: !isLoading,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Number of revisions (max. 500)',
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
                  isLoading ? null : handleSearchButtonPress();
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
