import 'package:flutter/material.dart';
import 'package:icons_finder/ext.dart';

Future<String?> showIconDialog(
  BuildContext context,
  IconData item,
  String key,
) {
  return showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text(key),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(item),
            const SizedBox(height: 17),
            Text(
              item.description,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Ok'),
          ),
        ],
      );
    },
  );
}
