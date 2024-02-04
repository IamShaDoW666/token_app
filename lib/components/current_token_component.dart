import 'package:flutter/material.dart';
import 'package:tokenapp/main.dart';
import 'package:tokenapp/model/tokens_response.dart';
import 'package:tokenapp/utils/configs.dart';
import 'package:tokenapp/utils/images.dart';
import 'package:tokenapp/utils/constant.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tokenapp/model/dashboard_response.dart';

class TodayCashComponent extends StatelessWidget {
  final TokensResponse snap;

  const TodayCashComponent({Key? key, required this.snap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        LiveStream().emit(LIVESTREAM_PROVIDER_ALL_BOOKING, 1);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: boxDecorationDefault(
            borderRadius: radius(), color: context.cardColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SpinKitDoubleBounce(
              size: 100,
              color: context.primaryColor,
            ),
            if (snap.tokensForCall!.isNotEmpty)
              Column(
                children: List.generate(
                    snap.tokensForCall!.length,
                    (index) =>
                        Text(snap.tokensForCall![index].number.toString())),
              )

            // PriceWidget(price: todayCashAmount, color: appStore.isDarkMode ? Colors.white : context.primaryColor),
          ],
        ),
      ),
    );
  }
}
