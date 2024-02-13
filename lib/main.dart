import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tokenapp/model/dashboard_response.dart';
import 'package:tokenapp/model/tokens_response.dart';
import 'package:tokenapp/screens/auth/sign_in_screen.dart';
import 'package:tokenapp/screens/provider/provider_dashboard_screen.dart';
import 'package:tokenapp/store/app_store.dart';
import 'package:tokenapp/utils/constant.dart';

AppStore appStore = AppStore();
DashboardResponse? cachedProviderDashboardResponse;
TokensResponse? cachedTokenResponse;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  await appStore.setLoggedIn(getBoolAsync(IS_LOGGED_IN));
  await appStore.setToken(getStringAsync(TOKEN), isInitializing: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DigiImpact Token System',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
          useMaterial3: true,
        ),
        home: appStore.isLoggedIn
            ? const ProviderDashboardScreen()
            : SignInScreen());
  }
}
