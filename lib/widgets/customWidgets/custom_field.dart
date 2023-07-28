import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  const CustomField({super.key, required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: TextFormField(
        readOnly: true,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
        initialValue: value,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          label: Text(label),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
