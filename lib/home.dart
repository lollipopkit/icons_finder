import 'package:flutter/material.dart';
import 'package:icons_finder/dialog.dart';
import 'package:icons_finder/ext.dart';
import 'package:icons_finder/search.dart';
import 'package:icons_plus/icons_plus.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MediaQueryData? _media;
  int _crossAxisCount = 7;
  static const _size = 77;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _media = MediaQuery.of(context);
    _crossAxisCount = (_media!.size.width / _size).floor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Icons Finder'),
      ),
      body: _buildList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showSearch(
          context: context,
          delegate: IconSearchDelegate(),
        ),
        tooltip: 'Search',
        child: const Icon(Icons.search),
      ),
    );
  }

  Widget _buildList() {
    final iconPacks = packNames.values.toList();
    final iconPackNames = packNames.keys.toList();
    return ListView.builder(
      itemCount: packNames.length,
      itemBuilder: (context, index) {
        final pack = iconPacks[index];
        final names = pack.keys.toList();
        final icons = pack.values.toList();
        return ExpansionTile(
          title: Text(iconPackNames[index].capitalize),
          children: [
            SizedBox(
              height: _size * pack.length / _crossAxisCount,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _crossAxisCount,
                ),
                itemCount: icons.length,
                itemBuilder: (_, idx) {
                  final name = names[idx];
                  final icon = icons[idx];
                  return IconButton(
                    onPressed: () => showIconDialog(context, icon, name),
                    icon: Icon(icon),
                    tooltip: name,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
