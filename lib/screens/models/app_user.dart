class AppUser {
  String userId;
  String? name;
  String? email;
  String? city;
  String? state;
  List<String>? currCrops;
  String ? curDeaseas;


  AppUser({
    required this.userId,
    this.name,
    this.email,
    this.curDeaseas,
    this.city,
    this.state,
    this.currCrops,
  });


  Map<String, dynamic> toJson() => {
    'userId': userId,
    'name': name,
    'currDecease' :curDeaseas,
    'email': email,
    'city': city,
    'state': state,
    'currCrops': currCrops,
  };
}








