import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:a2s_widgets/persisted_model.dart';

class PersistedModelListView extends StatelessWidget {
  final PersistedModel model;
  final List<String> titleKeys;
  final String subtitleKey;
  final Function onItemTap;

  PersistedModelListView(this.model,
      {@required this.titleKeys, this.subtitleKey, this.onItemTap});

  List<Widget> _buildTitleRowChildren(Map<String, dynamic> map) {
    List<Widget> cells = [];
    titleKeys.forEach((String key) {
      print("$key : ${map[key].toString()}");
      if (map.containsKey(key)) {
        cells.add(Text(map[key].toString()));
      }
    });
    return cells;
  }

  Widget _buildSubtitle(Map<String, dynamic> map) {
    if (subtitleKey == null) return null;
    if (!map.containsKey(subtitleKey)) return null;
    return Text(map[subtitleKey]);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        child: ScopedModelDescendant<PersistedModel>(
            builder: (context, child, model) {
          return ListView.builder(
              itemCount: model.data.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  child: ListTile(
                    onTap: () {
                      if (onItemTap != null) {
                        onItemTap(index);
                      }
                    },
                    title: Row(
                      children: _buildTitleRowChildren(model.data[index]),
                    ),
                    subtitle: _buildSubtitle((model.data[index])),
                  ),
                  onDismissed: (direction) {
                    model.delete(index);
                  },
                  key: Key(model.data[index]["_id"]),
                );
              });
        }),
        model: model);
  }
}
