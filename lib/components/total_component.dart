// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:tokenapp/model/dashboard_response.dart';
import 'package:tokenapp/components/total_widget.dart';
import 'package:tokenapp/model/tokens_response.dart';
import 'package:tokenapp/utils/images.dart';
// import 'package:tokenapp/main.dart';
// import 'package:tokenapp/utils/common.dart';
import 'package:tokenapp/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

class TotalComponent extends StatelessWidget {
  final TokensResponse snap;

  // ignore: use_key_in_widget_constructors
  const TotalComponent({required this.snap});

  // TotalComponent({required this.snap});
  // const TotalComponent({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        TotalWidget(title: "token", total: "10", icon: total_booking).onTap(
          () {
            LiveStream().emit(LIVESTREAM_PROVIDER_ALL_BOOKING, 1);
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        TotalWidget(
          title: "next",
          total: "10",
          icon: total_services,
        ).onTap(
          () {
            LiveStream().emit(LIVESTREAM_PROVIDER_ALL_BOOKING, 1);
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        TotalWidget(title: "token", total: "10", icon: total_booking).onTap(
          () {
            LiveStream().emit(LIVESTREAM_PROVIDER_ALL_BOOKING, 1);
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        TotalWidget(
          title: "next",
          total: "10",
          icon: total_services,
        ).onTap(
          () {
            LiveStream().emit(LIVESTREAM_PROVIDER_ALL_BOOKING, 1);
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
      ],
    ).paddingAll(16);
  }
}
