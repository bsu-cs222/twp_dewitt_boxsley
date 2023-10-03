import 'package:flutter/cupertino.dart';

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
