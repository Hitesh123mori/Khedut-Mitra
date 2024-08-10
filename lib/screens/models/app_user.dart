class AppUser {
  String userId;
  String? name;
  String? email;
  String? city;
  String? state;
  List<String>? currCrops;

  AppUser({
    required this.userId,
    this.name,
    this.email,
    this.city,
    this.state,
    this.currCrops,
  });


  Map<String, dynamic> toJson() => {
    'userId': userId,
    'name': name,
    'email': email,
    'city': city,
    'state': state,
    'currCrops': currCrops,
  };
}








