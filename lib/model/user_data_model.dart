class UserData {
  int? id;
  String? email;
  String? name;
  String? apiToken;
  String? image;
  int? status;
  String? userType;

  UserData({
    this.email,
    this.id,
    this.name,
    this.apiToken,
    this.image,
    this.status,
    this.userType,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    apiToken = json['api_token'];
    image = json['image'];
    status = json['status'];
    userType = json['user_type'];
  }
  bool get isUserActive => status == 0;
  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals, unnecessary_new
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (apiToken != null) data['api_token'] = apiToken;
    if (email != null) data['email'] = email;
    if (name != null) data['name'] = name;
    if (id != null) data['id'] = id;
    if (image != null) data['image'] = image;
    if (status != null) data['status'] = status;
    if (userType != null) data['user_type'] = userType;

    return data;
  }
}
