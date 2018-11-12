import 'package:flutter/material.dart';
import 'package:rapido/document_list.dart';
import 'package:rapido/document_widgets.dart';

// import 'package:rapido/document_list_view.dart';
// import 'package:rapido/add_document_floating_action_button.dart';

/// Convenience UI for creating all create, update, and delete UI
/// for a given DocumentList. It will generate a default ListView.
/// Can be customized with a customIemBuilder and/or a decoration.
/// decoration, customItemBuild, and emptuListWidget, are passed
/// through to the DocumentListView.
class DocumentListScaffold extends StatefulWidget {
  final DocumentList documentList;
  final String title;
  final Function onItemTap;
  final List<String> titleKeys;
  final String subtitleKey;
  final BoxDecoration decoration;
  final Function customItemBuilder;
  final Widget emptyListWidget;

  DocumentListScaffold(this.documentList,
      {@required this.title,
      this.onItemTap,
      @required this.titleKeys,
      this.subtitleKey,
      this.decoration,
      this.customItemBuilder,
      this.emptyListWidget});

  _DocumentListScaffoldState createState() => _DocumentListScaffoldState();
}

class _DocumentListScaffoldState extends State<DocumentListScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: DocumentListView(
          widget.documentList,
          titleKeys: widget.titleKeys,
          subtitleKey: widget.subtitleKey,
          onItemTap: widget.onItemTap,
          customItemBuilder: widget.customItemBuilder,
          emptyListWidget: widget.emptyListWidget,
        ),
        decoration: widget.decoration,
      ),
      floatingActionButton: AddDocumentFloatingActionButton(widget.documentList),
    );
  }
}