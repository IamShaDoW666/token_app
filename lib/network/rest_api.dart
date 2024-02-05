import 'dart:async';

import 'package:nb_utils/nb_utils.dart';
import 'package:tokenapp/model/dashboard_response.dart';
import 'package:tokenapp/model/login_model.dart';
import 'package:tokenapp/model/token_model.dart';
import 'package:tokenapp/model/tokens_response.dart';
import 'package:tokenapp/network/network_utils.dart';
import 'package:tokenapp/main.dart';
import 'package:tokenapp/model/user_data_model.dart';
import 'package:tokenapp/model/base_response_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

Future<LoginResponse> createUser(Map request) async {
  return LoginResponse.fromJson(await (handleResponse(await buildHttpResponse(
      'register',
      request: request,
      method: HttpMethodType.POST))));
}

Future<LoginResponse> loginUser(Map request,
    {bool isSocialLogin = false}) async {
  request.remove("uid");
  appStore.setLoading(true);
  LoginResponse res = LoginResponse.fromJson(await handleResponse(
      await buildHttpResponse(isSocialLogin ? 'social-login' : 'login',
          request: request, method: HttpMethodType.POST)));
  return res;
}

Future<BaseResponseModel> forgotPassword(Map request) async {
  return BaseResponseModel.fromJson(await handleResponse(
      await buildHttpResponse('forgot-password',
          request: request, method: HttpMethodType.POST)));
}

Future<Token> callnext(Map request) async {
  return Token.fromJson(await handleResponse(await buildHttpResponse('callnext',
      request: request, method: HttpMethodType.POST)));
}

Future<DashboardResponse> dashboardData() async {
  final completer = Completer<DashboardResponse>();
  try {
    final data = DashboardResponse.fromJson(await handleResponse(
        await buildHttpResponse('dashboard', method: HttpMethodType.GET)));

    completer.complete(data);
    // Perform additional code or post-processing
    _performAdditionalProcessingProvider(data);
  } catch (e) {
    appStore.setLoading(false);
    completer.completeError(e);
  }
  return completer.future;
}

void _performAdditionalProcessingProvider(DashboardResponse data) async {
  cachedProviderDashboardResponse = data;
  appStore.setLoading(false);
}

Future<TokensResponse> getTokens(Map request) async {
  final completer = Completer<TokensResponse>();
  try {
    final data = TokensResponse.fromJson(await handleResponse(
        await buildHttpResponse('get-tokens',
            request: request, method: HttpMethodType.POST)));

    completer.complete(data);
    cachedTokenResponse = data;
    appStore.setLoading(false);
  } catch (e) {
    appStore.setLoading(false);
    completer.completeError(e);
  }
  return completer.future;
}
