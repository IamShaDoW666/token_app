import 'dart:convert';
import 'dart:io';
import 'package:tokenapp/main.dart';
import 'package:tokenapp/utils/common.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tokenapp/utils/configs.dart';
import 'package:tokenapp/utils/constant.dart';
import 'package:tokenapp/screens/auth/sign_in_screen.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Map<String, String> buildHeaderTokens({
  Map? extraKeys,
}) {
  Map<String, String> header = {};

  /// Initialize & Handle if key is not present
  extraKeys ??= {};

  if (appStore.isLoggedIn) {
    header.putIfAbsent(
        HttpHeaders.authorizationHeader, () => 'Bearer ${appStore.token}');
  }
  header.putIfAbsent(
      HttpHeaders.contentTypeHeader, () => 'application/json; charset=utf-8');
  header.putIfAbsent(
      HttpHeaders.acceptHeader, () => 'application/json; charset=utf-8');
  header.putIfAbsent(HttpHeaders.cacheControlHeader, () => 'no-cache');
  header.putIfAbsent('Access-Control-Allow-Headers', () => '*');
  header.putIfAbsent('Access-Control-Allow-Origin', () => '*');

  log(jsonEncode(header));
  return header;
}

Uri buildBaseUrl(String endPoint) {
  Uri url = Uri.parse(endPoint);
  if (!endPoint.startsWith('http')) url = Uri.parse('$BASE_URL$endPoint');

  log('URL: ${url.toString()}');

  return url;
}

Future<Response> buildHttpResponse(
  String endPoint, {
  HttpMethodType method = HttpMethodType.GET,
  Map? request,
  Map? extraKeys,
}) async {
  if (await isNetworkAvailable()) {
    var headers = buildHeaderTokens(extraKeys: extraKeys);

    Uri url = buildBaseUrl(endPoint);

    Response response;

    if (method == HttpMethodType.POST) {
      // log('Request: ${jsonEncode(request)}');
      response =
          await http.post(url, body: jsonEncode(request), headers: headers);
    } else if (method == HttpMethodType.DELETE) {
      response = await delete(url, headers: headers);
    } else if (method == HttpMethodType.PUT) {
      response = await put(url, body: jsonEncode(request), headers: headers);
    } else {
      response = await get(url, headers: headers);
    }

    /* log('Response (${method.name}) ${response.statusCode}: ${response.body}'); */
    apiPrint(
      url: url.toString(),
      endPoint: endPoint,
      headers: jsonEncode(headers),
      hasRequest: method == HttpMethodType.POST || method == HttpMethodType.PUT,
      request: jsonEncode(request),
      statusCode: response.statusCode,
      responseBody: response.body,
      methodtype: method.name,
    );
    return response;
  }
  throw errorInternetNotAvailable;
}

void apiPrint({
  String url = "",
  String endPoint = "",
  String headers = "",
  String request = "",
  int statusCode = 0,
  String responseBody = "",
  String methodtype = "",
  bool hasRequest = false,
}) {
  log("┌───────────────────────────────────────────────────────────────────────────────────────────────────────");
  log("\u001b[93m Url: \u001B[39m $url");
  log("\u001b[93m Header: \u001B[39m \u001b[96m$headers\u001B[39m");
  if (request.isNotEmpty)
    log("\u001b[93m Request: \u001B[39m \u001b[96m$request\u001B[39m");
  log("${statusCode.isSuccessful() ? "\u001b[32m" : "\u001b[31m"}");
  log('Response ($methodtype) $statusCode: $responseBody');
  log("\u001B[0m");
  log("└───────────────────────────────────────────────────────────────────────────────────────────────────────");
}

Future handleResponse(Response response,
    {HttpResponseType httpResponseType = HttpResponseType.JSON,
    bool? avoidTokenError,
    bool? isSadadPayment}) async {
  if (!await isNetworkAvailable()) {
    throw errorInternetNotAvailable;
  }
  if (response.statusCode == 401) {
    if (!avoidTokenError.validate()) LiveStream().emit(LIVESTREAM_TOKEN, true);

    push(SignInScreen(isRegeneratingToken: true));
    throw 'Token Expired';
  } else if (response.statusCode == 400) {
    throw 'Bad Request';
  } else if (response.statusCode == 403) {
    throw 'Forbidden';
  } else if (response.statusCode == 404) {
    throw 'Not Found';
  } else if (response.statusCode == 429) {
    throw 'Too many requests}';
  } else if (response.statusCode == 500) {
    throw 'Internal Server Error';
  } else if (response.statusCode == 502) {
    throw 'Bad Gateway';
  } else if (response.statusCode == 503) {
    throw 'Service Unavailable';
  } else if (response.statusCode == 504) {
    throw 'Gateway Timeout';
  }

  if (response.statusCode.isSuccessful()) {
    return jsonDecode(response.body);
  } else {
    try {
      var body = jsonDecode(response.body);
      throw parseHtmlString(body['message']);
    } on Exception catch (e) {
      log(e);
      throw errorSomethingWentWrong;
    }
  }
}
