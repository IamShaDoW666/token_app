// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:tokenapp/main.dart';
import 'package:tokenapp/model/tokens_response.dart';
import 'package:tokenapp/network/rest_api.dart';
import 'package:tokenapp/utils/configs.dart';
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
    return Center(
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          ElevatedButton.icon(
              onPressed: () async {
                appStore.setLoading(true);
                await callnext(
                    {"service_id": 1, "counter_id": 1, "by_id": false});
                appStore.setLoading(false);
              },
              icon: const Icon(Icons.add_box),
              label: const Text(
                'CALL NEXT',
                style: TextStyle(color: white),
              ),
              style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(
                      Size((context.width() / 2) - 32, 54)),
                  backgroundColor:
                      MaterialStatePropertyAll(defaultPrimaryColor))),
          ElevatedButton.icon(
              onPressed: () async {
                if (snap.calledTokens!.isNotEmpty) {
                  appStore.setLoading(true);
                  await noShowApiToken({"call_id": snap.calledTokens![0].id});
                  appStore.setLoading(false);
                }
              },
              icon: const Icon(Icons.add_box),
              label: const Text('NO SHOW', style: TextStyle(color: white)),
              style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(
                      Size((context.width() / 2) - 32, 54)),
                  backgroundColor:
                      MaterialStatePropertyAll(defaultPrimaryColor))),
          ElevatedButton.icon(
              onPressed: () async {
                appStore.setLoading(true);
                await serveApiToken({"call_id": snap.calledTokens![0].id});
                appStore.setLoading(false);
              },
              icon: const Icon(Icons.add_box),
              label: const Text('SERVED', style: TextStyle(color: white)),
              style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(
                      Size((context.width() / 2) - 32, 54)),
                  backgroundColor:
                      MaterialStatePropertyAll(defaultPrimaryColor))),
          ElevatedButton.icon(
              onPressed: () async {
                appStore.setLoading(true);
                await callnext(
                    {"service_id": 1, "counter_id": 1, "by_id": false});
                appStore.setLoading(false);
              },
              icon: const Icon(Icons.add_box),
              label: const Text('NEXT', style: TextStyle(color: white)),
              style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(
                      Size((context.width() / 2) - 32, 54)),
                  backgroundColor:
                      MaterialStatePropertyAll(defaultPrimaryColor))),
        ],
      ).paddingAll(16),
    );
  }
}
