import 'package:tokenapp/main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tokenapp/network/rest_api.dart';
import 'package:flutter/cupertino.dart';

import 'package:tokenapp/model/user_data_model.dart';

Future<UserData> loginCurrentUsers(BuildContext context,
    {required Map<String, dynamic> req}) async {
  try {
    appStore.setLoading(true);
    final userValue = await loginUser(req);
    log("***************** Normal Login Succeeds*****************");
    return userValue.data!;
  } catch (e) {
    log(e);
    throw e.toString();
  }
}

void saveDataToPreference(BuildContext context,
    {required UserData userData,
    bool isSocialLogin = false,
    required Function onRedirectionClick}) async {
  onRedirectionClick.call();
  await appStore.setToken(userData.apiToken!);
  await appStore.setUserEmail(userData.email!);
  await appStore.setUserName(userData.name!);
}
