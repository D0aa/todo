class FireTask{
  String? id;
  String? userId;
  String? title;
  String? description;
  String? image;
  String? startDate;
  String? endDate;
  String? status;

  FireTask({this.userId, this.title, this.description, this.image,
    this.startDate, this.endDate, this.status,this.id});

  FireTask.fromJson(Map<String, dynamic> json,{String? id}) {
    this.id=id;
    userId = json['user_id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_id'] = userId;
    data['title'] = title;
    data['description'] = description;
    data['image'] = image;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['status'] = status;
    return data;
  }
}