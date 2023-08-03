import 'package:flutter/material.dart';

class CustomLookupField extends StatelessWidget {
  const CustomLookupField(
      {super.key,
      required this.value,
      required this.label,
      required this.lookupFunction,
      required this.icon});

  final String value;
  final String label;
  final Icon icon;

  final void Function() lookupFunction;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      // fit: FlexFit.loose,
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
          suffixIcon: IconButton(onPressed: lookupFunction, icon: icon),
        ),
      ),
    );
  }
}
