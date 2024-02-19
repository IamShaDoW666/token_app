// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tokenapp/components/app_widget.dart';
import 'package:tokenapp/components/current_token_component.dart';
import 'package:tokenapp/components/token_pending.dart';
import 'package:tokenapp/components/error_widget.dart';
import 'package:tokenapp/main.dart';
import 'package:tokenapp/model/counter_model.dart';
import 'package:tokenapp/model/responses/service_and_counter_response.dart';
import 'package:tokenapp/model/service_model.dart';
import 'package:tokenapp/model/token_model.dart';
import 'package:tokenapp/model/tokens_response.dart';
import 'package:tokenapp/network/rest_api.dart';
import 'package:tokenapp/components/total_component.dart';
import 'package:tokenapp/utils/common.dart';

class ProviderHomeFragment extends StatefulWidget {
  const ProviderHomeFragment({super.key});

  @override
  _ProviderHomeFragmentState createState() => _ProviderHomeFragmentState();
}

class _ProviderHomeFragmentState extends State<ProviderHomeFragment> {
  int page = 1;

  int currentIndex = 0;
  Future<TokensResponse>? future;
  late Future<ServiceAndCounterResponse>? servicesAndCounters;
  Service? selectedService;
  Counter? selectedCounter;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    selectedService = null;
    selectedCounter = null;
    servicesAndCounters = getServicesAndCounters();
  }

  void getTokenData() {
    future = getTokens({
      "service_id": appStore.serviceId.toString(),
      "counter_id": appStore.counterId.toString()
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void callNextFunction() async {
    appStore.setLoading(true);
    await callnext({
      "service_id": appStore.serviceId.toString(),
      "counter_id": appStore.counterId.toString(),
      "by_id": false
    });
    getTokenData();
    setState(() {});
    appStore.setLoading(false);
  }

  void selectCounterFunction() async {
    await appStore.setServiceId(-1);
    await appStore.setCounterId(-1);
    setState(() {});
  }

  void noShowFunction(List<Token>? calledTokens) async {
    if (calledTokens!.isNotEmpty) {
      appStore.setLoading(true);
      await noShowApiToken({"call_id": calledTokens[0].id});
      getTokenData();
      setState(() {});
      appStore.setLoading(false);
    }
  }

  void servedFunction(List<Token>? calledTokens) async {
    appStore.setLoading(true);
    await serveApiToken({"call_id": calledTokens![0].id});
    getTokenData();
    setState(() {});
    appStore.setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          if (appStore.serviceId! < 0 && appStore.counterId! < 0)
            SnapHelperWidget<ServiceAndCounterResponse>(
                future: servicesAndCounters,
                onSuccess: (snap) {
                  return AnimatedScrollView(
                    padding: const EdgeInsets.only(bottom: 16),
                    physics: const AlwaysScrollableScrollPhysics(),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    listAnimationType: ListAnimationType.FadeIn,
                    fadeInConfiguration:
                        FadeInConfiguration(duration: 2.seconds),
                    children: [
                      16.height,
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(16),
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.amber),
                        // padding: const EdgeInsets.all(26),
                        child: const Text(
                          textAlign: TextAlign.center,
                          'Select Service and Counter',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      selectWidget(context, snap),
                      16.height,
                      AppButton(
                        text: "Save",
                        height: 40,
                        color: Colors.amber,
                        textStyle: boldTextStyle(color: white),
                        width: context.width() - context.navigationBarHeight,
                        onTap: () async {
                          await appStore
                              .setServiceId(selectedService!.id.validate());
                          await appStore
                              .setCounterId(selectedCounter!.id.validate());
                          log(appStore.serviceId);
                          getTokenData();
                          setState(() {});
                        },
                      )
                    ],
                    onSwipeRefresh: () async {
                      page = 1;
                      appStore.setLoading(true);

                      init();
                      setState(() {});

                      return await 2.seconds.delay;
                    },
                  );
                }),
          if (appStore.serviceId! > 0 && appStore.counterId! > 0) tokenWidget(),
          Observer(
              builder: (context) => LoaderWidget().visible(appStore.isLoading))
        ],
      ),
    );
  }

  Column tokenWidget() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(26),
          child: const Text(
            "Now Running Token",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.normal,
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
                  16.height,
                  TotalComponent(
                      snap: snap.data!,
                      callNext: callNextFunction,
                      noShow: noShowFunction,
                      selectCounter: selectCounterFunction,
                      served: servedFunction),
                  16.height,
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(16),
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.amber),
                    // padding: const EdgeInsets.all(26),
                    child: const Text(
                      textAlign: TextAlign.center,
                      "Pending Tokens",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  TokenPending(snap: snap.data!),
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
      ],
    );
  }

  Column selectWidget(BuildContext context, ServiceAndCounterResponse snap) {
    return Column(
      children: [
        DropdownButtonFormField<Service>(
          decoration: inputDecoration(context,
              fillColor: context.scaffoldBackgroundColor,
              hint: "Select Service"),
          value: selectedService,
          dropdownColor: context.scaffoldBackgroundColor,
          items: snap.services!.map((data) {
            return DropdownMenuItem<Service>(
              value: data,
              child: Text(data.name.validate(), style: primaryTextStyle()),
            );
          }).toList(),
          onChanged: (value) async {
            selectedService = value!;
            setState(() {});
          },
        ),
        32.height,
        DropdownButtonFormField<Counter>(
          decoration: inputDecoration(context,
              fillColor: context.scaffoldBackgroundColor,
              hint: "Select Counter"),
          value: selectedCounter,
          dropdownColor: context.scaffoldBackgroundColor,
          items: snap.counters!.map((data) {
            return DropdownMenuItem<Counter>(
              value: data,
              child: Text(data.name.validate(), style: primaryTextStyle()),
            );
          }).toList(),
          onChanged: (value) async {
            selectedCounter = value!;
            setState(() {});
          },
        ),
      ],
    );
  }
}
