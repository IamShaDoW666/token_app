class Token {
  int? id;
  int? serviceId;
  String? letter;
  int? number;
  int? called;

  Token({this.id, this.serviceId, this.number, this.called});

  Token.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['service-id'];
    number = json['token_number'];
    called = json['called'];
    letter = json['token_letter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (serviceId != null) data['service_id'] = serviceId;
    if (called != null) data['called'] = called;
    if (letter != null) data['token_letter'] = letter;
    if (number != null) data['token_number'] = number;
    return data;
  }
}
