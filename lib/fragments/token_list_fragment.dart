import 'package:flutter/material.dart';
import 'package:tokenapp/components/base_scaffold_widget.dart';
import 'package:tokenapp/main.dart';
import 'package:tokenapp/model/token_model.dart';
import 'package:tokenapp/model/tokens_response.dart';
import 'package:tokenapp/components/token_widget.dart';
import 'package:tokenapp/network/rest_api.dart';
import 'package:tokenapp/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

class TokenListFragment extends StatefulWidget {
  const TokenListFragment({super.key});

  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<TokenListFragment> {
  late Future<TokensResponse> future;
  List<TokensResponse> list = [];
  int page = 1;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    future = getTokens({"service_id": 1, "counter_id": 1});
  }

  Widget listIterate(List<Token> list) {
    return AnimatedListView(
      shrinkWrap: true,
      itemCount: list.length,
      physics: const NeverScrollableScrollPhysics(),
      listAnimationType: ListAnimationType.FadeIn,
      fadeInConfiguration: FadeInConfiguration(duration: 2.seconds),
      slideConfiguration: SlideConfiguration(
          duration: 400.milliseconds, delay: 50.milliseconds),
      itemBuilder: (context, index) {
        Token data = list[index];

        return GestureDetector(
          onTap: () {},
          child: TokenWidget(
            data: data,
          ),
        );
      },
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    LiveStream().dispose(LIVESTREAM_UPDATE_NOTIFICATIONS);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarTitle: Navigator.canPop(context) ? 'No Show Tokens' : null,
      actions: [
        IconButton(
          icon: const Icon(Icons.clear_all_rounded, color: Colors.white),
          onPressed: () {},
        ),
      ],
      body: SnapHelperWidget<TokensResponse>(
        initialData: cachedTokenResponse,
        future: future,
        loadingWidget: Loader(),
        onSuccess: (list) {
          return AnimatedListView(
            itemCount: list.calledTokens!.length,
            shrinkWrap: true,
            listAnimationType: ListAnimationType.FadeIn,
            fadeInConfiguration: FadeInConfiguration(duration: 2.seconds),
            emptyWidget: NoDataWidget(
              title: 'Sorry',
              titleTextStyle: const TextStyle(fontSize: 34),
              subTitle: "No Called Tokens",
              subTitleTextStyle: const TextStyle(fontSize: 22),
              imageWidget: Container(),
            ),
            itemBuilder: (context, index) {
              Token data = list.calledTokens![index];
              return GestureDetector(
                child: TokenWidget(data: data),
              );
            },
            onSwipeRefresh: () async {
              page = 1;
              init();
              setState(() {});
              return await 2.seconds.delay;
            },
          );
        },
        errorBuilder: (error) {
          return NoDataWidget(
            title: error,
            imageWidget: Container(),
            retryText: 'Reload',
            onRetry: () {
              page = 1;
              appStore.setLoading(true);
              init();
              setState(() {});
            },
          );
        },
      ),
    );
  }
}
