import 'package:flutter/material.dart';
import 'package:tokenapp/components/spin_kit_chasing_dots.dart';
import 'package:tokenapp/utils/configs.dart';
import 'package:nb_utils/nb_utils.dart';

Widget placeHolderWidget(
    {String? placeHolderImage,
    double? height,
    double? width,
    BoxFit? fit,
    AlignmentGeometry? alignment}) {
  return PlaceHolderWidget(
    height: height,
    width: width,
    alignment: alignment ?? Alignment.center,
  );
}

class LoaderWidget extends StatelessWidget {
  final double? size;

  LoaderWidget({this.size});

  @override
  Widget build(BuildContext context) {
    return SpinKitChasingDots(color: primaryColor, size: size ?? 50);
  }
}
