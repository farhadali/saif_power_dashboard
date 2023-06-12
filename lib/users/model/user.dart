class User {
  int id;
  String name;
  String email;
  String password;

  User(
    this.id,
    this.name,
    this.email,
    this.password,
  );

  factory User.fromJson(Map<String, dynamic> json) => User(
        json["id"],
        json["name"],
        json["email"],
        json["password"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
      };
}
