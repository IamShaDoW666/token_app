// ignore_for_file: non_constant_identifier_names

import 'dart:collection';

class CallToken {
  int? id;
  String? name;
  String? letter;
  int? status;
  int? start_number;
  int? queue_id;
  String? token_letter;
  int? token_number;
  int? called_date;

  CallToken(
      {this.id,
      this.name,
      this.letter,
      this.status,
      this.start_number,
      this.queue_id,
      this.token_letter,
      this.token_number,
      this.called_date});

  CallToken.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    letter = json['letter'];
    status = json['status'];
    start_number = json['start_number'];
    queue_id = json['queue_id'];
    token_letter = json['token_letter'];
    token_number = json['token_number'];
    // called_date = json['called_date'];
    //called_date = int.tryParse(json['called_date'].toString());
  }
  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals, unnecessary_new
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (id != null) data['id'] = id;
    if (name != null) data['name'] = name;
    if (letter != null) data['letter'] = letter;
    if (status != null) data['status'] = status;
    if (start_number != null) data['start_number'] = start_number;
    if (queue_id != null) data['queue_id'] = queue_id;
    if (token_letter != null) data['token_letter'] = token_letter;
    if (token_number != null) data['token_number'] = token_number;
    if (called_date != null) data['called_date'] = called_date;

    return data;
  }
}
