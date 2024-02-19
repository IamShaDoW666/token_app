import 'package:tokenapp/model/counter_model.dart';
import 'package:tokenapp/model/service_model.dart';

class ServiceAndCounterResponse {
  List<Service>? services;
  List<Counter>? counters;

  ServiceAndCounterResponse({this.counters, this.services});

  ServiceAndCounterResponse.fromJson(Map<String, dynamic> json) {
    services = json['services'] != null
        ? (json['services'] as List).map((i) => Service.fromJson(i)).toList()
        : null;
    counters = json['counters'] != null
        ? (json['counters'] as List).map((i) => Counter.fromJson(i)).toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    if (counters != null) {
      data['counters'] = counters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
