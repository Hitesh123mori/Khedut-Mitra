class AppUser {
  AppUser({
    this.userId,
    this.name,
    this.email,
    this.city,
    this.state,
  });

  AppUser.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    email = json['email'];
    city = json['city'];
    state = json['state'];
  }

  String? userId;
  String? name;
  String? email;
  String? city;
  String? state;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['name'] = name;
    map['email'] = email;
    map['city'] = city;
    map['state'] = state;
    return map;
  }
}
