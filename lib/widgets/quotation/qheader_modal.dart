import 'package:flutter/material.dart';

class QHeaderModal extends StatelessWidget {
  const QHeaderModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      child: Text(
        "QHeader",
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
