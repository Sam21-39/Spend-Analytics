import 'package:flutter/material.dart';

class SpendCard extends StatelessWidget {
  const SpendCard({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(child: ListTile(title: Text(title), subtitle: Text(value)));
  }
}
