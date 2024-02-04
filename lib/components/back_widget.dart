import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tokenapp/utils/images.dart';
import 'package:tokenapp/utils/string_extensions.dart';


class BackWidget extends StatelessWidget {
  final Function()? onPressed;
  final Color? iconColor;

  BackWidget({this.onPressed, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ??
          () {
            finish(context);
          },
      icon: ic_arrow_left.iconImage(color: iconColor ?? Colors.white),
    );
  }
}