import 'package:equatable/equatable.dart';

class ChatUser extends Equatable {
  final int id;
  final String username;
  final String imageUrl;

  ChatUser({required this.id, required this.username, required this.imageUrl});

  @override
  // TODO: implement props
  List<Object?> get props => [id, username];
}
