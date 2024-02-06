// ignore_for_file: non_constant_identifier_names

class NoShow {
  bool? executed;

  NoShow({this.executed});

  NoShow.fromJson(Map<String, dynamic> json) {
    executed = json['already_executed'];
  }
  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals, unnecessary_new
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (executed != null) data['already_executed'] = executed;
    return data;
  }
}
