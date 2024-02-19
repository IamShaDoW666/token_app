class Service {
  int? id;
  String? name;
  int? status;
  String? letter;

  Service({this.id, this.name, this.status, this.letter});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    letter = json['letter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (name != null) data['name'] = name;
    if (status != null) data['status'] = status;
    if (letter != null) data['letter'] = letter;
    return data;
  }
}
