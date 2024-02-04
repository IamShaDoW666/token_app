class Token {
  int? id;
  int? serviceId;
  int? number;
  int? called;

  Token({this.id, this.serviceId, this.number, this.called});

  Token.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['service-id'];
    number = json['number'];
    called = json['called'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (serviceId != null) data['service_id'] = serviceId;
    if (called != null) data['called'] = called;
    return data;
  }
}
