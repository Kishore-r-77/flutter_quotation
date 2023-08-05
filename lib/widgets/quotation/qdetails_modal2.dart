import 'package:flutter/material.dart';

class QDetailsModal2 extends StatelessWidget {
  const QDetailsModal2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Text(
        "QDetails 2",
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
