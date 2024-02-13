import 'package:flutter/material.dart';
import 'package:tokenapp/utils/constant.dart';
import 'package:tokenapp/model/tokens_response.dart';
import 'package:nb_utils/nb_utils.dart';

class TokenPending extends StatelessWidget {
  final TokensResponse snap;
  const TokenPending({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          LiveStream().emit(LIVESTREAM_PROVIDER_ALL_BOOKING, 1);
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          
          child: Row(children: [
            // Row(
            //   children: [
            //     const Text("Pending", style: TextStyle(fontSize: 18))
            //         .paddingAll(12),
            //   ],
            // ),
            ...List.generate(
              snap.tokensForCall!.length,
              (index) => Row(
                children: [
                  Text(
                    '${snap.tokensForCall![index].letter} - ${snap.tokensForCall![index].number}',
                    style: const TextStyle(fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                  ).paddingAll(12),
                ],
              ),
            )
          ]),
        ));
  }
}
