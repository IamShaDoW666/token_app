import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tokenapp/utils/common.dart';
import 'package:tokenapp/utils/constant.dart';

part 'app_store.g.dart';

// ignore: library_private_types_in_public_api
class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  @observable
  bool isLoggedIn = false;
  @observable
  int? userId = -1;
  @observable
  int? serviceId = -1;
  @observable
  int? counterId = -1;
  @observable
  bool isLoading = false;
  @observable
  String loginType = '';
  @observable
  String userEmail = '';
  @observable
  String token = '';
  @observable
  String userName = '';
  @observable
  String userProfileImage = '';
  @observable
  String uid = '';

  @action
  Future<void> setUId(String val, {bool isInitializing = false}) async {
    uid = val;
    if (!isInitializing) await setValue(UID, val);
  }

  @action
  void setLoading(bool val) {
    isLoading = val;
  }

  @action
  Future<void> setUserProfile(String val, {bool isInitializing = false}) async {
    userProfileImage = val;
    if (!isInitializing) await setValue(PROFILE_IMAGE, val);
  }

  @action
  Future<void> setToken(String val, {bool isInitializing = false}) async {
    token = val;
    if (!isInitializing) await compareValuesInSharedPreference(TOKEN, val);
  }

  @action
  Future<void> setLoggedIn(bool val, {bool isInitializing = false}) async {
    isLoggedIn = val;
    if (!isInitializing) await setValue(IS_LOGGED_IN, val);
  }

  @action
  Future<void> setUserId(int val, {bool isInitializing = false}) async {
    userId = val;
    if (!isInitializing) await setValue(USER_ID, val);
  }

  @action
  Future<void> setUserEmail(String val, {bool isInitializing = false}) async {
    userEmail = val;
    if (!isInitializing) await setValue(USER_EMAIL, val);
  }

  @action
  Future<void> setUserName(String val, {bool isInitializing = false}) async {
    userName = val;
    if (!isInitializing) await setValue(USERNAME, val);
  }

  @action
  Future<void> setServiceId(int val) async {
    serviceId = val;
    await setValue(SERVICE_ID, val);
  }

  @action
  Future<void> setCounterId(int val) async {
    counterId = val;
    await setValue(COUNTER_ID, val);
  }
}
