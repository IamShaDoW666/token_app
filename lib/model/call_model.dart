import 'service_model.dart';

class CallModel {
  int? id;
  String? name;
  int? status;
  int? startNumber;
  int? queueId;
  String? tokenLetter;
  int? tokenNumber;
  int? calledDate;
  int? counterTime;
  Service? service;

  CallModel(
      {this.id,
      this.name,
      this.status,
      this.startNumber,
      this.queueId,
      this.tokenLetter,
      this.tokenNumber,
      this.calledDate,
      this.service,
      this.counterTime});

  CallModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    startNumber = json['start_number'];
    queueId = json['queue_id'];
    tokenLetter = json['tokenLetter'];
    tokenNumber = json['token_number'];
    counterTime = json['counter_time'];
    service =
        json['service'] != null ? Service.fromJson(json['service']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (name != null) data['name'] = name;
    if (status != null) data['status'] = status;
    if (startNumber != null) data['start_number'] = startNumber;
    if (queueId != null) data['queue_id'] = queueId;
    if (tokenLetter != null) data['tokenLetter'] = tokenLetter;
    if (tokenNumber != null) data['token_number'] = tokenNumber;
    if (calledDate != null) data['called_date'] = calledDate;
    if (counterTime != null) data['counter_time'] = counterTime;
    if (service != null) data['service'] = service!.toJson();

    return data;
  }
}
