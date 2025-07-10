import 'package:flutter/material.dart';
import 'package:github/features/github/domain/entities/repository_entity.dart';
import 'package:github/features/github/presentation/pages/repository_details_page.dart';
import 'package:github/features/github/presentation/widgets/stat_widget.dart';

class RepositoryListTile extends StatelessWidget {
  const RepositoryListTile({
    required this.repository,
    super.key,
  });

  final RepositoryEntity repository;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _navigateToDetails(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(repository.ownerAvatarUrl),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          repository.fullName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'by ${repository.owner}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (repository.description.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  repository.description,
                  style: const TextStyle(fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  if (repository.language.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        repository.language,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue[800],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  RepositoryStatWidget(
                    icon: Icons.star,
                    value: repository.stars.toString(),
                  ),
                  const SizedBox(width: 16),
                  RepositoryStatWidget(
                    icon: Icons.fork_right,
                    value: repository.forks.toString(),
                  ),
                  const SizedBox(width: 16),
                  RepositoryStatWidget(
                    icon: Icons.visibility,
                    value: repository.watchers.toString(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToDetails(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RepositoryDetailsPage(repository: repository),
      ),
    );
  }
}
