import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github/features/github/presentation/cubits/repositories_cubit.dart';
import 'package:github/features/github/presentation/cubits/repositories_state.dart';
import 'package:github/features/github/presentation/widgets/empty_repositories_widget.dart';
import 'package:github/features/github/presentation/widgets/error_widget.dart';
import 'package:github/features/github/presentation/widgets/initial_repository_searching_widget.dart';
import 'package:github/features/github/presentation/widgets/repository_list_tile.dart';

class RepositoriesPage extends StatefulWidget {
  const RepositoriesPage({super.key});

  @override
  State<RepositoriesPage> createState() => _RepositoriesPageState();
}

class _RepositoriesPageState extends State<RepositoriesPage> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<RepositoriesCubit>().searchRepositories(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Repositories'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          _buildSearchField(context),
          Expanded(
            child: _buildRepositoriesList(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search repositories...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
        onChanged: _onSearchChanged,
      ),
    );
  }

  Widget _buildRepositoriesList(BuildContext context) {
    return BlocBuilder<RepositoriesCubit, RepositoriesState>(
      builder: (context, state) {
        return switch (state) {
          RepositoriesInitial() => const InitialRepositorySearchWidget(),
          RepositoriesLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
          RepositoriesError(message: final message) =>
            RepositoriesErrorWidget(message: message),
          RepositoriesLoaded(
            repositories: final repositories,
            query: final query
          ) =>
            repositories.isEmpty
                ? EmptyRepositoriesWidget(query: query)
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: repositories.length,
                    itemBuilder: (context, index) {
                      final repository = repositories[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: RepositoryListTile(repository: repository),
                      );
                    },
                  ),
        };
      },
    );
  }
}
