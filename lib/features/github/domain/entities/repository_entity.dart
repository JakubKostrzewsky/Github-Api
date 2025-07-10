import 'package:equatable/equatable.dart';

class RepositoryEntity extends Equatable {
  const RepositoryEntity({
    required this.id,
    required this.name,
    required this.fullName,
    required this.description,
    required this.owner,
    required this.ownerAvatarUrl,
    required this.language,
    required this.stars,
    required this.forks,
    required this.watchers,
    required this.htmlUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RepositoryEntity.fromJson(Map<String, dynamic> json) {
    return RepositoryEntity(
      id: json['id'] as int,
      name: json['name'] as String,
      fullName: json['full_name'] as String,
      description: json['description'] as String? ?? '',
      owner: (json['owner'] as Map<String, dynamic>)['login'] as String,
      ownerAvatarUrl:
          (json['owner'] as Map<String, dynamic>)['avatar_url'] as String,
      language: json['language'] as String? ?? 'Unknown',
      stars: json['stargazers_count'] as int,
      forks: json['forks_count'] as int,
      watchers: json['watchers_count'] as int,
      htmlUrl: json['html_url'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  final int id;
  final String name;
  final String fullName;
  final String description;
  final String owner;
  final String ownerAvatarUrl;
  final String language;
  final int stars;
  final int forks;
  final int watchers;
  final String htmlUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
        id,
        name,
        fullName,
        description,
        owner,
        ownerAvatarUrl,
        language,
        stars,
        forks,
        watchers,
        htmlUrl,
        createdAt,
        updatedAt,
      ];
}
