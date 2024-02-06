import 'package:tokenapp/model/counter_model.dart';
import 'package:tokenapp/model/queue_model.dart';
import 'package:tokenapp/model/token_model.dart';
import 'service_model.dart';

class TokensResponse {
  Service? service;
  Counter? counter;
  List<QueueModel>? tokensForCall;
  List<Token>? calledTokens;
  TokensResponse(
      {this.service, this.counter, this.calledTokens, this.tokensForCall});

  TokensResponse.fromJson(Map<String, dynamic> json) {
    service =
        json['service'] != null ? Service.fromJson(json['service']) : null;
    counter =
        json['counter'] != null ? Counter.fromJson(json['counter']) : null;
    tokensForCall = json['tokens_for_call'] != null
        ? (json['tokens_for_call'] as List)
            .map((i) => QueueModel.fromJson(i))
            .toList()
        : null;
    calledTokens = json['called_tokens'] != null
        ? (json['called_tokens'] as List).map((i) => Token.fromJson(i)).toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (service != null) data['service'] = service!.toJson();
    if (counter != null) data['counter'] = counter!.toJson();
    if (tokensForCall != null) {
      data['tokens_for_call'] = tokensForCall!.map((v) => v.toJson()).toList();
    }
    if (calledTokens != null) {
      data['called_tokens'] = calledTokens!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
