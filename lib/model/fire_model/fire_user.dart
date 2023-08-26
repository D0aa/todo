class FireUser{
  String? uid;
  String? name;
  String? email;

  FireUser({this.uid, this.name, this.email});

  FireUser.fromJson(Map<String,dynamic>json){
    uid =json['uid'];
    name =json['name'];
    email =json['email'];
  }
}