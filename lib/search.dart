import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:icons_finder/dialog.dart';
import 'package:icons_finder/ext.dart';
import 'package:icons_finder/future.dart';
import 'package:icons_plus/icons_plus.dart';

final class IconSearchDelegate extends SearchDelegate<String> {
  IconSearchDelegate();

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildList(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildList(context);
  }

  Widget _buildList(BuildContext context) {
    return FutureWidget<Map<String, IconData>>(
      future: compute(_filter, query),
      loading: const SizedBox(
        width: 300,
        child: SizedBox(
          width: 77,
          height: 77,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      error: (error, trace) {
        return ListTile(
          title: const Text('Error'),
          subtitle: Text('$error'),
        );
      },
      success: (data) {
        if (data == null || data.isEmpty) {
          return const SizedBox();
        }
        final keys = data.keys.toList();
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 7),
          itemCount: data.length,
          itemBuilder: (_, index) {
            final key = keys[index];
            final item = data[key];
            if (item == null) {
              return const SizedBox();
            }
            final description = item.description;
            return ListTile(
              title: Text(key),
              leading: Icon(item),
              subtitle: Text(
                description,
                style: const TextStyle(color: Colors.grey),
              ),
              onTap: () => showIconDialog(context, item, key),
            );
          },
        );
      },
    );
  }
}

Future<Map<String, IconData>> _filter(String keyword) async {
  final map = <String, IconData>{};
  for (final pack in packNames.values) {
    for (final entry in pack.entries) {
      if (entry.key.contains(keyword)) {
        map[entry.key] = entry.value;
      }
    }
  }
  return map;
}
