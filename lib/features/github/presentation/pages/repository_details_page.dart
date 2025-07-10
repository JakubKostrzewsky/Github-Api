import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github/core/di/injectable.dart';
import 'package:github/features/github/domain/entities/repository_entity.dart';
import 'package:github/features/github/presentation/cubits/repository_details/repository_details_cubit.dart';
import 'package:github/features/github/presentation/cubits/repository_details/repository_details_state.dart';
import 'package:github/features/github/presentation/widgets/error_widget.dart';
import 'package:github/features/github/presentation/widgets/issues_tab.dart';
import 'package:github/features/github/presentation/widgets/pull_requests_tab.dart';

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
        title: Text(widget.repository.fullName),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Issues'),
            Tab(text: 'Pull Requests'),
          ],
        ),
      ),
      body: BlocBuilder<RepositoryDetailsCubit, RepositoryDetailsState>(
        builder: (context, state) {
          return switch (state) {
            RepositoryDetailsLoading() =>
              const Center(child: CircularProgressIndicator()),
            RepositoryDetailsLoaded(:final details) => TabBarView(
                controller: _tabController,
                children: [
                  IssuesTab(issues: details.issues),
                  PullRequestsTab(pullRequests: details.pullRequests),
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
