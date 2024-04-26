import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              final data = '${item.fontFamily ?? ''}.$key';
              Clipboard.setData(ClipboardData(text: data));
              Navigator.of(context).pop();
            },
            child: const Text('Copy'),
          ),
        ],
      );
    },
  );
}
