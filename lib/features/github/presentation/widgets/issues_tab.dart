import 'package:flutter/material.dart';
import 'package:github/features/github/domain/entities/issue_entity.dart';

class IssuesTab extends StatelessWidget {
  const IssuesTab({required this.issues, super.key});

  final List<IssueEntity> issues;

  @override
  Widget build(BuildContext context) {
    if (issues.isEmpty) {
      return const Center(
        child: Text('No issues found'),
      );
    }

    return ListView.builder(
      itemCount: issues.length,
      itemBuilder: (context, index) {
        final issue = issues[index];
        return ListTile(
          title: Text(issue.title),
          subtitle: Text('By ${issue.user} • ${issue.state}'),
          trailing: Chip(
            label: Text('#${issue.number}'),
            backgroundColor: issue.state == 'open'
                ? Colors.green.withValues(alpha: 0.2)
                : Colors.red.withValues(alpha: 0.2),
          ),
        );
      },
    );
  }
}
