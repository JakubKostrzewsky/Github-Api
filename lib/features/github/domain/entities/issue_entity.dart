import 'package:equatable/equatable.dart';

class IssueEntity extends Equatable {
  const IssueEntity({
    required this.id,
    required this.number,
    required this.title,
    required this.body,
    required this.state,
    required this.user,
    required this.userAvatarUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.htmlUrl,
  });

  factory IssueEntity.fromJson(Map<String, dynamic> json) {
    return IssueEntity(
      id: json['id'] as int,
      number: json['number'] as int,
      title: json['title'] as String,
      body: json['body'] as String? ?? '',
      state: json['state'] as String,
      user: (json['user'] as Map<String, dynamic>)['login'] as String,
      userAvatarUrl: (json['user'] as Map<String, dynamic>)['avatar_url'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      htmlUrl: json['html_url'] as String,
    );
  }

  final int id;
  final int number;
  final String title;
  final String body;
  final String state;
  final String user;
  final String userAvatarUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String htmlUrl;

  @override
  List<Object?> get props => [
        id,
        number,
        title,
        body,
        state,
        user,
        userAvatarUrl,
        createdAt,
        updatedAt,
        htmlUrl,
      ];
}
