class UserRegister {
  String? name;
  String? email;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? profileUrl;

  UserRegister(
      {this.name,
        this.email,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.profileUrl});

  UserRegister.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    profileUrl = json['profile_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['email'] = email;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['profile_url'] = profileUrl;
    return data;
  }
}