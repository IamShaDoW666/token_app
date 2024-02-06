import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tokenapp/utils/configs.dart';

class TotalWidget extends StatelessWidget {
  final String title;
  final String icon;
  final Color? color;

  const TotalWidget({
    super.key,
    required this.title,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: boxDecorationDefault(color: defaultPrimaryColor),
      width: context.width() / 2 - 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Marquee(
                  child: Text(title,
                      style:
                          secondaryTextStyle(size: 24, color: Colors.white))),
              // SizedBox(
              //   width: context.width() / 2 - 94,
              //   // child: Marquee(
              //   //   // child: Marquee(
              //   //   //     child: Text(total.validate(),
              //   //   //         style: boldTextStyle(color: Colors.white, size: 16),
              //   //   //         maxLines: 1)),
              //   // ),
              // ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: Image.asset(icon,
                    width: 18, height: 18, color: context.primaryColor),
              ),
            ],
          ),
          8.height,
          // Marquee(
          //     child: Text(title,
          //         style: secondaryTextStyle(size: 14, color: Colors.white))),
        ],
      ),
    );
  }
}
