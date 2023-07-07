
class UserModel {
  String id;
  String username;
  String ?photo;
  String phoneNumber;
  String email;
  String committee;
  String role;
  String password;


  UserModel({
    required this.username,
    required this.committee,
    required this.role,
    required this.phoneNumber,
    required this.email,
     this.photo,
    required this.id,
    required this.password
  });

  factory UserModel.fromJson({required dynamic json}) => UserModel(
        username: json['username'] ?? '',
        committee: json['committee'] ?? '',
        role: json['role'] ?? '',
        phoneNumber: json['phone_number'] ?? '',
        email: json['email'] ?? '',
        photo: json['photo'] ?? '',
        id:json['id']??0,
       password:json['password'] ?? '',
      );
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['committee']=this.committee;
    data['username'] = this.username;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    data['role'] = this.role;
    data['photo'] = this.photo;
    data['password'] = this.password;
    return data;
  }

}




