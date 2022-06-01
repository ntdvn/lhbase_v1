import 'package:equatable/equatable.dart';

class LhChatUser extends Equatable {
  final int id;
  final String username;
  final String imageUrl;

  LhChatUser({required this.id, required this.username, required this.imageUrl});

  @override
  List<Object?> get props => [id, username];
}
