class User {
  int? id;
  String name;
  String email;

  User({this.id, required this.name, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
