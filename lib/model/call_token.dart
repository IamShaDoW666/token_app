// ignore_for_file: non_constant_identifier_names

class CallToken {
  int? id;
  String? name;
  String? letter;
  int? status;
  int? start_number;

  CallToken({this.id, this.name, this.letter, this.status, this.start_number});

  CallToken.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    letter = json['letter'];
    status = json['status'];
    start_number = json['start_number'];
  }
  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals, unnecessary_new
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (id != null) data['id'] = id;
    if (name != null) data['name'] = name;
    if (letter != null) data['letter'] = letter;
    if (status != null) data['status'] = status;
    if (start_number != null) data['start_number'] = start_number;

    return data;
  }
}
