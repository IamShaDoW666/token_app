import 'package:flutter/material.dart';
import 'package:tokenapp/main.dart';
import 'package:tokenapp/utils/constant.dart';
import 'package:tokenapp/utils/colors.dart';
import 'package:tokenapp/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tokenapp/utils/string_extensions.dart';
import 'package:tokenapp/fragments/provider_home_fragment.dart';
import 'package:tokenapp/fragments/provider_profile_fragment.dart';
import 'package:tokenapp/fragments/token_list_fragment.dart';

class ProviderDashboardScreen extends StatefulWidget {
  final int? index;

  // ignore: use_key_in_widget_constructors
  const ProviderDashboardScreen({this.index});

  @override
  ProviderDashboardScreenState createState() => ProviderDashboardScreenState();
}

class ProviderDashboardScreenState extends State<ProviderDashboardScreen> {
  int currentIndex = 0;

  DateTime? currentBackPressTime;

  List<Widget> fragmentList = [
    const ProviderHomeFragment(),
    const ProviderProfileFragment(),
  ];

  List<String> screenName = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    LiveStream().on(LIVESTREAM_PROVIDER_ALL_BOOKING, (index) {
      currentIndex = index as int;
      setState(() {});
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
    LiveStream().dispose(LIVESTREAM_PROVIDER_ALL_BOOKING);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        DateTime now = DateTime.now();

        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime!) >
                const Duration(seconds: 2)) {
          currentBackPressTime = now;
          // toast("hi");
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        appBar: appBarWidget(
          ['Home', 'Profile'][currentIndex],
          color: Colors.amber,
          textColor: Colors.black,
          showBack: false,
          actions: [
            IconButton(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  ic_show.iconImage(color: Colors.black, size: 34),
                ],
              ),
              onPressed: () async {
                const TokenListFragment().launch(context);
              },
            ),
          ],
        ),
        body: fragmentList[currentIndex],
        bottomNavigationBar: Blur(
          blur: 30,
          borderRadius: radius(0),
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
              backgroundColor: context.primaryColor.withOpacity(0.02),
              indicatorColor: context.primaryColor.withOpacity(0.1),
              labelTextStyle:
                  MaterialStateProperty.all(primaryTextStyle(size: 12)),
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            child: NavigationBar(
              selectedIndex: currentIndex,
              // ignore: prefer_const_literals_to_create_immutables
              destinations: [
                NavigationDestination(
                  icon: ic_home.iconImage(color: appTextSecondaryColor),
                  selectedIcon:
                      ic_fill_home.iconImage(color: context.primaryColor),
                  label: "Home",
                ),
                NavigationDestination(
                  icon: total_booking.iconImage(color: appTextSecondaryColor),
                  selectedIcon:
                      fill_ticket.iconImage(color: context.primaryColor),
                  label: "Profile",
                ),
                //   NavigationDestination(
                //     icon: un_fill_wallet.iconImage(color: appTextSecondaryColor),
                //     selectedIcon:
                //         ic_fill_wallet.iconImage(color: context.primaryColor),
                //     label: languages.lblPayment,
                //   ),
                //   NavigationDestination(
                //     icon: profile.iconImage(color: appTextSecondaryColor),
                //     selectedIcon:
                //         ic_fill_profile.iconImage(color: context.primaryColor),
                //     label: languages.lblProfile,
                //   ),
              ],
              onDestinationSelected: (index) {
                currentIndex = index;
                setState(() {});
              },
            ),
          ),
        ),
      ),
    );
  }
}
