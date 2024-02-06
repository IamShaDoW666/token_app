// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tokenapp/components/app_widget.dart';
import 'package:tokenapp/components/current_token_component.dart';
import 'package:tokenapp/components/error_widget.dart';
import 'package:tokenapp/main.dart';
import 'package:tokenapp/model/tokens_response.dart';
import 'package:tokenapp/network/rest_api.dart';
import 'package:tokenapp/components/total_component.dart';

class ProviderHomeFragment extends StatefulWidget {
  const ProviderHomeFragment({super.key});

  @override
  _ProviderHomeFragmentState createState() => _ProviderHomeFragmentState();
}

class _ProviderHomeFragmentState extends State<ProviderHomeFragment> {
  int page = 1;

  int currentIndex = 0;
  late Future<TokensResponse> future;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    future = getTokens({"service_id": 1, "counter_id": 1});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(26),
            child: const Text(
              "Now Running Token",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FutureBuilder<TokensResponse>(
            future: future,
            initialData: cachedTokenResponse,
            builder: (context, snap) {
              if (snap.hasData) {
                return AnimatedScrollView(
                  padding: const EdgeInsets.only(bottom: 16),
                  physics: const AlwaysScrollableScrollPhysics(),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  listAnimationType: ListAnimationType.FadeIn,
                  fadeInConfiguration: FadeInConfiguration(duration: 2.seconds),
                  children: [
                    TodayCashComponent(snap: snap.data!),
                    // TodayCashComponent(snap: snap.data!),
                    TotalComponent(snap: snap.data!),
                    // Text(snap.data!.token_letter.toString()),
                    // Text(snap.data!.yesterday.toString()),
                  ],
                  onSwipeRefresh: () async {
                    page = 1;
                    appStore.setLoading(true);

                    init();
                    setState(() {});

                    return await 2.seconds.delay;
                  },
                );
              }

              return snapWidgetHelper(
                snap,
                loadingWidget: Container(),
                errorBuilder: (error) {
                  return NoDataWidget(
                    title: error,
                    imageWidget: const ErrorStateWidget(),
                    retryText: "Retry",
                    onRetry: () {
                      page = 1;
                      appStore.setLoading(true);

                      init();
                      setState(() {});
                    },
                  );
                },
              );
            },
          ),
          Observer(
              builder: (context) => LoaderWidget().visible(appStore.isLoading))
        ],
      ),
    );
  }
}
