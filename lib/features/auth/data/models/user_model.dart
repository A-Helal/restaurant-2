import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String uid;
  final String email;
  final String displayName;
  
  const UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
  });
  
  @override
  List<Object?> get props => [uid, email, displayName];
  
  Map<String, dynamic> toJson() => {
    'uid': uid,
    'email': email,
    'displayName': displayName,
  };
  
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    uid: json['uid'] ?? '',
    email: json['email'] ?? '',
    displayName: json['displayName'] ?? '',
  );
  
  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
    );
  }
} 