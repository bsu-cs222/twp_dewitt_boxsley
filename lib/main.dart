import 'package:flutter/material.dart';
import 'package:twp_dewitt_boxsley/widgets/results_list_widget.dart';
import 'package:twp_dewitt_boxsley/widgets/search_redirect_notice_widget.dart';
import 'package:twp_dewitt_boxsley/widgets/user_input_widget.dart';

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
