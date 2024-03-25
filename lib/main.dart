import 'package:flutter/material.dart';
import 'package:icons_finder/search.dart';
import 'package:icons_plus/icons_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Icons Finder',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Icons Finder'),
      ),
      body: _buildList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapSearch,
        tooltip: 'Search',
        child: const Icon(Icons.search),
      ),
    );
  }

  Widget _buildList() {
    final iconPackNames = packNames.keys.toList();
    final iconPacks = packNames.values.toList();
    return ListView.builder(
      itemCount: packNames.length,
      itemBuilder: (context, index) {
        final name = iconPackNames[index].capitalize;
        final pack = iconPacks[index];
        final names = pack.keys.toList();
        final icons = pack.values.toList();
        return ExpansionTile(
          title: Text(name),
          children: [
            SizedBox(
              height: 37 * icons.length / 7,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7),
                itemCount: icons.length,
                itemBuilder: (_, idx) {
                  return IconButton(
                    onPressed: () {
                      final icon = icons[idx];
                      final name = names[idx];
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(name),
                            content: Icon(icon),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(icons[idx]),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _onTapSearch() {
    showSearch(
      context: context,
      delegate: IconSearchDelegate(),
    );
  }
}

extension StringX on String {
  String get capitalize => '${this[0].toUpperCase()}${substring(1)}';
}
