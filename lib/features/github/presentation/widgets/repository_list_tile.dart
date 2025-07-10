import 'package:flutter/material.dart';
import 'package:github/features/github/domain/entities/repository_entity.dart';
import 'package:github/features/github/presentation/pages/repository_details_page.dart';

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
          child: Row(
            children: [
              // Repository icon
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(repository.ownerAvatarUrl),
              ),
              const SizedBox(width: 12),
              // Title and subtitle
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
                      repository.description.isNotEmpty
                          ? repository.description
                          : 'by ${repository.owner}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // Opening icon
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[400],
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
