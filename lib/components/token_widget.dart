import 'package:flutter/material.dart';
import 'package:tokenapp/model/token_model.dart';
import 'package:tokenapp/network/rest_api.dart';
import 'package:tokenapp/utils/colors.dart';
import 'package:tokenapp/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tokenapp/utils/string_extensions.dart';

class TokenWidget extends StatelessWidget {
  final Token data;

  const TokenWidget({super.key, required this.data});

  Color _getBGColor(BuildContext context) {
    return context.scaffoldBackgroundColor;
  }

  Color getColorForToken(Token token) {
    if (token.callStatus == 'no_show') {
      return failed;
    } else if (token.callStatus == 'called') {
      return completed;
    } else {
      return hold;
    }
  }

  Color getColorForRecall(Token token) {
    if (token.callStatus == 'no_show') {
      return completed;
    } else if (token.callStatus == 'called') {
      return failed;
    } else {
      return hold;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: boxDecorationDefault(
        color: _getBGColor(context),
        borderRadius: radius(0),
      ),
      child: Row(
        children: [
          Text(
            '${data.letter} - ${data.number.toString()}',
            style: boldTextStyle(size: 24),
          ).expand(),
          // Text(data.id.toString(), style: secondaryTextStyle(size: 10)
          // ),
          if (data.callStatus != 'pending')
            IconButton(
              disabledColor: Colors.red,
              icon: ic_calling.iconImage(
                  color: getColorForRecall(data), size: 34),
              onPressed: () async {
                await recallToken({"call_id": data.id});
              },
            ),
          8.width,
          Container(
            width: 32,
            height: 32,
            decoration: boxDecorationDefault(color: getColorForToken(data)),
            child: Center(
                child: Text(
              data.callStatus == 'no_show'
                  ? 'N'
                  : data.callStatus == 'called'
                      ? 'S'
                      : 'P',
              style: boldTextStyle(color: Colors.white),
            )),
          )
        ],
      ),
    );
  }
}
