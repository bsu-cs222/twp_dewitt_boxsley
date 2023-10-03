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

  bool isLoading = false;

  setIsLoading(bool state) => setState(() => isLoading = state);

  final pageNameController = TextEditingController();
  final numberOfRevisionsController = TextEditingController();

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

  void handleSearchButtonPress() async {
    revisionsList = [];

    final userSearchTerm = pageNameController.text;
    int userRequestedNumberOfRevisions;

    try {
      userRequestedNumberOfRevisions = int.parse(numberOfRevisionsController.text);
    } catch (e) {
      invalidNumberOfRevisionsDialog();
      return;
    }

    if (userRequestedNumberOfRevisions > 500 || userRequestedNumberOfRevisions < 1) {
      invalidNumberOfRevisionsDialog();
      return;
    }

    final String url = buildUrl(userSearchTerm, userRequestedNumberOfRevisions);
    final String jsonData = await fetchData(url);

    DataParser pageData = DataParser(jsonData);
    final pageExists = pageData.pageExists();
    final wasRedirected = pageData.wasRedirected();
    final pageName = pageData.getPageName();

    if (pageExists) {
      buildRevisionsList(pageData);

      widget.searchRedirectNoticeWidgetCallback(SearchRedirectNoticeWidget(
        wasRedirected: wasRedirected,
        userSearchTerm: userSearchTerm,
        redirectedSearchTerm: pageName,
      ));

      widget.resultsListWidgetCallback(ResultsListWidget(
        pageName: pageName,
        resultsList: revisionsList,
      ));
    } else {
      pageCannotBeFoundDialog(userSearchTerm);
    }
  }

  String buildUrl(String userSearchTerm, int numberOfRevisions) {
    UrlBuilder urlBuilder = UrlBuilder();
    return urlBuilder.buildUrl(userSearchTerm, numberOfRevisions);
  }

  Future<String> fetchData(url) async {
    DataFetcher dataFetcher = DataFetcher();
    String jsonData = '';

    try {
      setIsLoading(true);
      jsonData = await dataFetcher.fetchData(url);
    } catch (e) {
      networkErrorDialog();
    } finally {
      setIsLoading(false);
    }

    return jsonData;
  }

  buildRevisionsList(DataParser pageData) {
    final int availableRevisions = pageData.getNumberOfRevisions();
    for (int i = 0; i < availableRevisions; i++) {
      Revision revision = pageData.getRevision(i);
      revisionsList.add(ListItem(
        userName: revision.userName,
        timestamp: revision.timestamp,
      ));
    }
  }

  networkErrorDialog() {
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
    }
  }

  invalidNumberOfRevisionsDialog() {
    if (mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Invalid number of revisions'),
          content: const Text('Please enter a whole number in the range of 1 to 500.'),
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

  pageCannotBeFoundDialog(String userSearchTerm) {
    if (mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('No such page'),
          content: Text('The Wikipedia page for "$userSearchTerm" cannot be found. Try checking your spelling or entering a different search term.'),
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
