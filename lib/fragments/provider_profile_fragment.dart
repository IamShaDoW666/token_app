// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tokenapp/main.dart';
import 'package:tokenapp/screens/auth/sign_in_screen.dart';
import 'package:tokenapp/components/cached_image_widget.dart';
import 'package:tokenapp/model/dashboard_response.dart';
import 'package:tokenapp/model/user_data_model.dart';
import 'package:tokenapp/network/rest_api.dart';
import 'package:tokenapp/utils/colors.dart';
import 'package:tokenapp/utils/common.dart';
import 'package:tokenapp/utils/configs.dart';
import 'package:tokenapp/utils/constant.dart';

import 'package:nb_utils/nb_utils.dart';

class ProviderProfileFragment extends StatefulWidget {
  final List<UserData>? list;

  const ProviderProfileFragment({this.list});

  @override
  ProviderProfileFragmentState createState() => ProviderProfileFragmentState();
}

class ProviderProfileFragmentState extends State<ProviderProfileFragment> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) {
          return AnimatedScrollView(
              listAnimationType: ListAnimationType.FadeIn,
              fadeInConfiguration: FadeInConfiguration(duration: 2.seconds),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    24.height,
                    Stack(alignment: Alignment.bottomRight, children: [
                      Container(
                          decoration: boxDecorationDefault(
                            border: Border.all(
                                color: context.scaffoldBackgroundColor,
                                width: 4),
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            decoration: boxDecorationDefault(
                              border: Border.all(
                                  color: context.scaffoldBackgroundColor,
                                  width: 4),
                              shape: BoxShape.circle,
                            ),
                            child: CachedImageWidget(
                              url: appStore.userProfileImage.validate(),
                              height: 90,
                              fit: BoxFit.cover,
                              circle: true,
                            ),
                          ))
                    ]),
                    16.height,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          appStore.userName,
                          style: boldTextStyle(color: primaryColor, size: 16),
                        ),
                        4.height,
                        Text(appStore.userEmail, style: secondaryTextStyle()),
                      ],
                    ),
                  ],
                ).center().visible(appStore.isLoggedIn),
                16.height,
                Center(
                  child: AppButton(
                    height: 40,
                    color: primaryColor,
                    text: "Log Out",
                    width: context.width() - 42,
                    onTap: () {
                      appStore.setLoggedIn(false);
                      appStore.setToken('');
                      SignInScreen().launch(context,
                          pageRouteAnimation: PageRouteAnimation.Fade);
                    },
                    // child: Text('Logout',
                    //         style: boldTextStyle(color: primaryColor, size: 16))
                    //     .center()
                    //     .visible(appStore.isLoggedIn),
                  ),
                ),
              ]);
        },
      ),
    );
  }
}
