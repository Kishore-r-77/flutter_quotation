import 'package:flutter/material.dart';

class QDetailsModal1 extends StatelessWidget {
  const QDetailsModal1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: Text(
        "QDetails 1",
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
