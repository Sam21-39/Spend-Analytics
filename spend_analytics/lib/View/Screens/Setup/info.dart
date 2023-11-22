import 'package:flutter/material.dart';
import 'package:spend_analytics/Core/Widget/base_scaffold.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseScaffold(
      title: 'Information Fill Up',
      appBarColor: theme.colorScheme.background,
      backgroundColor: theme.colorScheme.background,
      body: Column(
        children: [],
      ),
    );
  }
}
