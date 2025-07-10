import 'package:flutter/material.dart';
import 'package:github/features/github/domain/entities/pull_request_entity.dart';

class PullRequestsTab extends StatelessWidget {
  const PullRequestsTab({
    required this.pullRequests,
    super.key,
  });

  final List<PullRequestEntity> pullRequests;

  @override
  Widget build(BuildContext context) {
    if (pullRequests.isEmpty) {
      return const Center(
        child: Text('No pull requests found'),
      );
    }

    return ListView.builder(
      itemCount: pullRequests.length,
      itemBuilder: (context, index) {
        final pr = pullRequests[index];
        return ListTile(
          title: Text(pr.title),
          subtitle: Text('By ${pr.user} • ${pr.state}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (pr.isMerged) const Icon(Icons.merge, color: Colors.purple),
              Chip(
                label: Text('#${pr.number}'),
                backgroundColor:
                    pr.state == 'open' ? Colors.green.withValues(alpha: 0.2) : Colors.red.withValues(alpha: 0.2),
              ),
            ],
          ),
        );
      },
    );
  }
}
