import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class NavigationControls extends StatelessWidget {
  const NavigationControls({required this.controller, super.key});

  final WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: SColors.black,),
          onPressed: () async {
            final messenger = ScaffoldMessenger.of(context);
            if (await controller.canGoBack()) {
              await controller.goBack();
            } else {
              messenger.showSnackBar(
                const SnackBar(content: Text('No back history item'), duration: Duration(seconds: 1)),
              );
              return;
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios, color: SColors.black,),
          onPressed: () async {
            final messenger = ScaffoldMessenger.of(context);
            if (await controller.canGoForward()) {
              await controller.goForward();
            } else {
              messenger.showSnackBar(
                const SnackBar(content: Text('No forward history item'), duration: Duration(seconds: 1),),
              );
              return;
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.replay, color: SColors.black,),
          onPressed: () {
            controller.reload();
          },
        ),
      ],
    );
  }
}

class WebViewScreen extends StatefulWidget {
  final String? url;
  final Uri? uri;
  final String? header;
  const WebViewScreen({super.key, this.url, this.uri, this.header});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController controller;
  var loadingPercentage = 0;
  bool loading = false, errorLoading = false;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();

    // #docregion webview_controller
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            setState(() {
              loadingPercentage = progress;
              errorLoading = true;
              errorMessage = "WebView is loading (progress : $progress%)";
            });
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {
            if(mounted){
              setState(() {
                errorLoading = true;
                errorMessage = error.description;
              });
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(widget.uri ?? Uri.parse("https://${widget.url ?? "flutter.dev"}"));
    // #enddocregion webview_controller
  }

  // #docregion webview_widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            CupertinoIcons.chevron_back,
            color: Theme.of(context).primaryColorLight,
            size: 28
          )
        ),
        title: SText(
          text: widget.header ?? "Serch - Service Made Easy",
          color: Theme.of(context).primaryColorLight,
          size: 22,
          weight: FontWeight.bold
        ),
        actions: [
          NavigationControls(controller: controller)
        ],
      ),
      body: loadingPercentage < 100 ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SLoader.fallingDot(size: 50, color: SColors.black),
            const SizedBox(height: 5),
            SText(
              text: "Loading ${loadingPercentage.toString()}%",
              color: SColors.black,
              size: 16,
              weight: FontWeight.bold,
            )
          ],
        ),
      ) : loadingPercentage >= 100 ? WebViewWidget(controller: controller) : Center(
        child: SText(
          text: errorMessage,
          color: SColors.black,
          size: 16
        )
      )
    );
  }
  // #enddocregion webview_widget
}