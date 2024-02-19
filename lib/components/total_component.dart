import 'package:flutter/material.dart';
import 'package:tokenapp/model/token_model.dart';
import 'package:tokenapp/model/tokens_response.dart';
import 'package:nb_utils/nb_utils.dart';

class TotalComponent extends StatelessWidget {
  final TokensResponse snap;
  final Function callNext;
  final Function selectCounter;
  final Function(List<Token>) noShow;
  final Function(List<Token>) served;

  const TotalComponent(
      {super.key,
      required this.snap,
      required this.selectCounter,
      required this.callNext,
      required this.noShow,
      required this.served});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          ElevatedButton.icon(
              onPressed: () {
                selectCounter();
              },
              icon: const Icon(
                Icons.add_box,
                color: Colors.black,
              ),
              label: const Text(
                'SELECT COUNTER',
                style: TextStyle(color: black),
              ),
              style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(
                      Size((context.width() / 2) - 32, 54)),
                  backgroundColor:
                      const MaterialStatePropertyAll(Colors.amber))),
          ElevatedButton.icon(
              onPressed: () {
                noShow(snap.calledTokens.validate());
              },
              icon: const Icon(
                Icons.add_box,
                color: Colors.black,
              ),
              label: const Text('NO SHOW', style: TextStyle(color: black)),
              style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(
                      Size((context.width() / 2) - 32, 54)),
                  backgroundColor:
                      const MaterialStatePropertyAll(Colors.amber))),
          ElevatedButton.icon(
              onPressed: () {
                served(snap.calledTokens.validate());
              },
              icon: const Icon(
                Icons.add_box,
                color: Colors.black,
              ),
              label: const Text('SERVED', style: TextStyle(color: black)),
              style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(
                      Size((context.width() / 2) - 32, 54)),
                  backgroundColor:
                      const MaterialStatePropertyAll(Colors.amber))),
          ElevatedButton.icon(
              onPressed: () {
                callNext();
              },
              icon: const Icon(
                Icons.add_box,
                color: Colors.black,
              ),
              label: const Text('NEXT', style: TextStyle(color: black)),
              style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(
                      Size((context.width() / 2) - 32, 54)),
                  backgroundColor:
                      const MaterialStatePropertyAll(Colors.amber))),
        ],
      ).paddingAll(16),
    );
  }
}
