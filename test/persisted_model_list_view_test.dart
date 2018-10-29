import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:a2s_widgets/persisted_model_list_view.dart';
import 'package:a2s_widgets/persisted_model.dart';
import 'dart:io';
import 'package:flutter/services.dart';

void main() {
  testWidgets('Can display fields as title and subtitle', (WidgetTester tester) async {
    PersistedModel testModel = PersistedModel("testDocumentType");
    for (int i = 0; i < 10; i++) {
      if(i == 1) {
      testModel.add({ "field B": "${i.toString()}", "field C":"subtitle"});
      }
      else {
        testModel.add({ "field B": "${i.toString()}"});
      }
    }
    await tester.pumpWidget(
      MaterialApp (
        home: Scaffold(
        body: PersistedModelListView(
            testModel,
            titleKeys: ["field B", "field A"],
            subtitleKey: "field C",
          ),
        ),
      ),
    );
    expect(find.text("2"),findsOneWidget );
    expect(find.text("subtitle"),findsOneWidget );
    expect(find.text("aaa"), findsNothing);
    expect(find.text("null"), findsNothing);
  }

  );

  setUpAll(() async {
    // Create a temporary directory to work with
    final directory = await Directory.systemTemp.createTemp();

    // Mock out the MethodChannel for the path_provider plugin
    const MethodChannel('plugins.flutter.io/path_provider')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      // If we're getting the apps documents directory, return the path to the
      // temp directory on our test environment instead.
      if (methodCall.method == 'getApplicationDocumentsDirectory') {
        return directory.path;
      }
      return null;
    });
  });
}