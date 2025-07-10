import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github/core/di/injectable.dart';
import 'package:github/features/github/domain/entities/repository_entity.dart';
import 'package:github/features/github/presentation/cubits/repository_details/repository_details_cubit.dart';
import 'package:github/features/github/presentation/cubits/repository_details/repository_details_state.dart';
import 'package:github/features/github/presentation/widgets/error_widget.dart';
import 'package:github/features/github/presentation/widgets/issues_tab.dart';
import 'package:github/features/github/presentation/widgets/pull_requests_tab.dart';
import 'package:github/features/github/presentation/widgets/stat_widget.dart';

class RepositoryDetailsPage extends StatefulWidget {
  const RepositoryDetailsPage({
    required this.repository,
    super.key,
  });

  final RepositoryEntity repository;

  @override
  State<RepositoryDetailsPage> createState() => _RepositoryDetailsPageState();
}

class _RepositoryDetailsPageState extends State<RepositoryDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl.get<RepositoryDetailsCubit>()
        ..loadRepositoryDetails(
          owner: widget.repository.owner,
          repo: widget.repository.name,
        ),
      child: _RepositoryDetailsContent(repository: widget.repository),
    );
  }
}

class _RepositoryDetailsContent extends StatefulWidget {
  const _RepositoryDetailsContent({
    required this.repository,
  });

  final RepositoryEntity repository;

  @override
  State<_RepositoryDetailsContent> createState() =>
      _RepositoryDetailsContentState();
}

class _RepositoryDetailsContentState extends State<_RepositoryDetailsContent>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.repository.name),
      ),
      body: BlocBuilder<RepositoryDetailsCubit, RepositoryDetailsState>(
        builder: (context, state) {
          return switch (state) {
            RepositoryDetailsLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            RepositoryDetailsLoaded(:final details) => Column(
                children: [
                  _RepositoryHeader(repository: widget.repository),
                  Expanded(
                    child: Column(
                      children: [
                        TabBar(
                          controller: _tabController,
                          tabs: const [
                            Tab(text: 'Issues'),
                            Tab(text: 'Pull Requests'),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              IssuesTab(issues: details.issues),
                              PullRequestsTab(
                                  pullRequests: details.pullRequests),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            RepositoryDetailsError(:final message) =>
              RepositoriesErrorWidget(message: message),
          };
        },
      ),
    );
  }
}

class _RepositoryHeader extends StatelessWidget {
  const _RepositoryHeader({
    required this.repository,
  });

  final RepositoryEntity repository;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: theme.dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Repository name and owner
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
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'by ${repository.owner}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodySmall?.color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Description
          if (repository.description.isNotEmpty) ...[
            Text(
              repository.description,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
          ],

          // Stats row
          Row(
            children: [
              StatWidget(
                icon: Icons.star,
                value: repository.stars.toString(),
                label: 'Stars',
              ),
              const SizedBox(width: 16),
              StatWidget(
                icon: Icons.fork_right,
                value: repository.forks.toString(),
                label: 'Forks',
              ),
              const SizedBox(width: 16),
              StatWidget(
                icon: Icons.visibility,
                value: repository.watchers.toString(),
                label: 'Watchers',
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Language
          if (repository.language != 'Unknown')
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                repository.language,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
