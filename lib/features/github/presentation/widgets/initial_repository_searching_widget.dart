import 'package:flutter/material.dart';

class InitialRepositorySearchWidget extends StatelessWidget {
  const InitialRepositorySearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Start typing to search repositories',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }
}
