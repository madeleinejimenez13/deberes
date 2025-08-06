// lib/models/user.dart
class User {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? name;
  final String? job;
  final String? email;
  final String? avatar;
  final String? createdAt;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.name,
    this.job,
    this.email,
    this.avatar,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      name: json['name'],
      job: json['job'],
      email: json['email'],
      avatar: json['avatar'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (job != null) 'job': job,
      if (email != null) 'email': email,
    };
  }

  String get displayName {
    if (name != null) return name!;
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    }
    return 'Usuario $id';
  }
}