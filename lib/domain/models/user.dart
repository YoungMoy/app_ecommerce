class User {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? address;
  final String? avatarUrl;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.address,
    this.avatarUrl,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? address,
    String? avatarUrl,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json,
  ) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'avatarUrl': avatarUrl,
    };
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is User &&
            id == other.id &&
            name == other.name &&
            email == other.email &&
            phone == other.phone &&
            address == other.address &&
            avatarUrl == other.avatarUrl;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      name,
      email,
      phone,
      address,
      avatarUrl,
    );
  }
}