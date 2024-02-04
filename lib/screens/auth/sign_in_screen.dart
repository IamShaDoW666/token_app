// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tokenapp/model/user_data_model.dart';
import 'package:tokenapp/utils/common.dart';
import 'package:tokenapp/screens/auth/auth_user_services.dart';
import 'package:tokenapp/screens/provider/provider_dashboard_screen.dart';
import 'package:tokenapp/components/selected_item_widget.dart';
import 'package:tokenapp/components/app_widget.dart';
import 'package:tokenapp/utils/constant.dart';
import 'package:tokenapp/main.dart';
import 'package:tokenapp/utils/images.dart';
import 'package:tokenapp/utils/string_extensions.dart';
import 'package:tokenapp/screens/auth/forgot_password_screen.dart';
import 'package:tokenapp/utils/configs.dart';

class SignInScreen extends StatefulWidget {
  final bool isRegeneratingToken;

  // ignore: use_key_in_widget_constructors, prefer_const_constructors_in_immutables
  SignInScreen({this.isRegeneratingToken = false});

  @override
  // ignore: library_private_types_in_public_api
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  bool isRemember = true;
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    isRemember = getBoolAsync(IS_REMEMBERED, defaultValue: true);
    if (isRemember) {
      emailCont.text = getStringAsync(USER_EMAIL);
      passwordCont.text = getStringAsync(USER_PASSWORD);
    }
    if (widget.isRegeneratingToken) {
      emailCont.text = appStore.userEmail;
      passwordCont.text = getStringAsync(USER_PASSWORD);

      _handleLogin(isDirectLogin: true);
    }
  }

  Widget _buildTopWidget() {
    return Column(
      children: [
        32.height,
        Text("Token", style: boldTextStyle(size: 18)).center(),
        16.height,
        Text(
          "Welcome",
          style: secondaryTextStyle(size: 14),
          textAlign: TextAlign.center,
        ).paddingSymmetric(horizontal: 32).center(),
        64.height,
      ],
    );
  }

  Widget _buildFormWidget() {
    return AutofillGroup(
      onDisposeAction: AutofillContextAction.commit,
      child: Column(
        children: [
          AppTextField(
            textFieldType: TextFieldType.EMAIL_ENHANCED,
            controller: emailCont,
            focus: emailFocus,
            nextFocus: passwordFocus,
            errorThisFieldRequired: "hint",
            decoration: inputDecoration(context, hint: "hi"),
            suffix: ic_message.iconImage(size: 10).paddingAll(14),
            // ignore: prefer_const_literals_to_create_immutables
            autoFillHints: [AutofillHints.email],
          ),
          16.height,
          AppTextField(
            textFieldType: TextFieldType.PASSWORD,
            controller: passwordCont,
            focus: passwordFocus,
            errorThisFieldRequired: "hint",
            suffixPasswordVisibleWidget:
                ic_show.iconImage(size: 10).paddingAll(14),
            suffixPasswordInvisibleWidget:
                ic_hide.iconImage(size: 10).paddingAll(14),
            errorMinimumPasswordLength:
                "${"paasslength"} $passwordLengthGlobal",
            decoration: inputDecoration(context, hint: "password"),
            // ignore: prefer_const_literals_to_create_immutables
            autoFillHints: [AutofillHints.password],
            onFieldSubmitted: (s) {
              _handleLogin();
            },
          ),
          8.height,
        ],
      ),
    );
  }

  Widget _buildForgotRememberWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                2.width,
                SelectedItemWidget(isSelected: isRemember).onTap(() async {
                  await setValue(IS_REMEMBERED, isRemember);
                  isRemember = !isRemember;
                  setState(() {});
                }),
                TextButton(
                  onPressed: () async {
                    await setValue(IS_REMEMBERED, isRemember);
                    isRemember = !isRemember;
                    setState(() {});
                  },
                  child: Text("remember me", style: secondaryTextStyle()),
                ),
              ],
            ),
            TextButton(
              child: Text(
                "forgot password",
                style: boldTextStyle(
                    color: primaryColor, fontStyle: FontStyle.italic),
                textAlign: TextAlign.right,
              ),
              onPressed: () {
                showInDialog(
                  context,
                  contentPadding: EdgeInsets.zero,
                  dialogAnimation: DialogAnimation.SLIDE_TOP_BOTTOM,
                  builder: (_) => ForgotPasswordScreen(),
                );
              },
            ).flexible()
          ],
        ),
        32.height,
      ],
    );
  }

  Widget _buildButtonWidget() {
    return Column(
      children: [
        AppButton(
          text: "Sign In",
          height: 40,
          color: primaryColor,
          textStyle: boldTextStyle(color: white),
          width: context.width() - context.navigationBarHeight,
          onTap: () {
            _handleLogin();
          },
        ),
        16.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("No Account", style: secondaryTextStyle()),
            TextButton(
              onPressed: () {
                //SignUpScreen().launch(context);
              },
              child: Text(
                "Sign Up",
                style: boldTextStyle(
                  color: primaryColor,
                  decoration: TextDecoration.underline,
                  fontStyle: FontStyle.italic,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  void _handleLogin({bool isDirectLogin = false}) {
    if (isDirectLogin) {
      _handleLoginUsers();
    } else {
      hideKeyboard(context);
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        _handleLoginUsers();
      }
    }
  }

  void _handleLoginUsers() async {
    hideKeyboard(context);
    Map<String, dynamic> request = {
      'email': emailCont.text.trim(),
      'password': passwordCont.text.trim(),
      // 'player_id': getStringAsync(PLAYERID),
    };

    log(request);

    await loginCurrentUsers(context, req: request).then((value) async {
      log(value);
      if (isRemember) {
        setValue(USER_EMAIL, emailCont.text);
        setValue(USER_PASSWORD, passwordCont.text);
        setValue(IS_REMEMBERED, isRemember);
      }

      saveDataToPreference(context, userData: value, onRedirectionClick: () {
        redirectWidget(res: value);
      });
      appStore.setLoading(false);
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString());
    });
  }

  void redirectWidget({required UserData res}) async {
    TextInput.finishAutofillContext();
    await appStore.setLoggedIn(true);
    await appStore.setToken(res.apiToken.validate());
    const ProviderDashboardScreen(index: 0).launch(context,
        isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        "",
        elevation: 0,
        showBack: false,
        color: context.scaffoldBackgroundColor,
        // systemUiOverlayStyle: SystemUiOverlayStyle(
        //     statusBarIconBrightness:
        //         getStatusBrightness(val: appStore.isDarkMode),
        //     statusBarColor: context.scaffoldBackgroundColor),
      ),
      body: SizedBox(
        width: context.width(),
        child: Stack(
          children: [
            Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTopWidget(),
                    _buildFormWidget(),
                    _buildForgotRememberWidget(),
                    _buildButtonWidget(),
                    16.height,
                    SnapHelperWidget<bool>(
                        future: isIqonicProduct,
                        onSuccess: (data) {
                          // if (data) {
                          //   return UserDemoModeScreen(
                          //     onChanged: (email, password) {
                          //       if (email.isNotEmpty && password.isNotEmpty) {
                          //         emailCont.text = email;
                          //         passwordCont.text = password;
                          //       } else {
                          //         emailCont.clear();
                          //         passwordCont.clear();
                          //       }
                          //     },
                          //   );
                          // }
                          return const Offstage();
                        }),
                  ],
                ),
              ),
            ),
            Observer(
              builder: (_) =>
                  LoaderWidget().center().visible(appStore.isLoading),
            ),
          ],
        ),
      ),
    );
  }
}
