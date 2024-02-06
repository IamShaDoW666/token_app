class QueueModel {
  int? id;
  int? serviceId;
  String? letter;
  int? number;
  int? called;

  QueueModel({this.id, this.serviceId, this.number, this.called});

  QueueModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['service-id'];
    number = json['number'];
    called = json['called'];
    letter = json['letter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (serviceId != null) data['service_id'] = serviceId;
    if (called != null) data['called'] = called;
    if (letter != null) data['letter'] = letter;
    return data;
  }
}
