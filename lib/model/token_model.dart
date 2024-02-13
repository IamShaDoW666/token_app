class Token {
  int? id;
  int? serviceId;
  String? letter;
  int? number;
  int? called;
  String? callStatus;

  Token({this.id, this.serviceId, this.number, this.called, this.callStatus});

  Token.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['service-id'];
    number = json['token_number'];
    called = json['called'];
    letter = json['token_letter'];
    callStatus = json['call_status_id'] == 1
        ? 'called'
        : json['call_status_id'] == 2
            ? 'no_show'
            : 'pending';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (serviceId != null) data['service_id'] = serviceId;
    if (called != null) data['called'] = called;
    if (letter != null) data['token_letter'] = letter;
    if (number != null) data['token_number'] = number;
    if (callStatus != null) {
      if (callStatus == 'called') {
        data['call_status_id'] = 1;
      } else if (callStatus == 'no_show') {
        data['call_status_id'] = 2;
      } else {
        data['call_status_id'] = 0;
      }
    }
    return data;
  }
}
