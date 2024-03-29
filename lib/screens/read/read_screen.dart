import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../theme/theme.dart';
import 'widgets/read_app_bar.dart';

class ReadScreen extends StatefulWidget {
  final String? url;
  final Color backgroundColor;

  const ReadScreen({
    required this.url,
    required this.backgroundColor,
  });

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  WebViewController? controller;

  @override
  void initState() {
    super.initState();

    final uri = Uri.tryParse(widget.url ?? '');

    if (uri != null) {
      initializeWebView(uri);
    }
  }

  Future<void> initializeWebView(Uri uri) async {
    controller = WebViewController();

    await controller?.setJavaScriptMode(JavaScriptMode.unrestricted);
    await controller?.setBackgroundColor(widget.backgroundColor);
    await controller?.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (progress) {},
        onPageStarted: (url) {},
        onPageFinished: (url) {},
        onWebResourceError: (error) {},
        onNavigationRequest: (request) => NavigationDecision.navigate,
      ),
    );
    await controller?.loadRequest(uri);

    log('Loaded');

    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: context.colors.background,
        extendBodyBehindAppBar: true,
        appBar: ReadAppBar(),
        body: Animate(
          effects: const [
            FadeEffect(
              curve: Curves.easeIn,
              duration: Duration(milliseconds: 450),
            ),
          ],
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 450),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeIn,
            child: controller != null
                ? WebViewWidget(
                    controller: controller!,
                  )
                : Container(
                    height: 150,
                    width: 150,
                    color: Colors.indigoAccent,
                  ),
          ),
        ),
      );
}
