import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MiniAppPage extends StatefulWidget {
  final String linkUrl;
  const MiniAppPage({super.key, required this.linkUrl});

  @override
  State<MiniAppPage> createState() => _MiniAppPageState();
}

class _MiniAppPageState extends State<MiniAppPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..loadRequest(
        Uri.parse(widget.linkUrl),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Flutter WebView',
            style: TextStyle(fontSize: 20),
          ),
          actions: [
            IconButton(
                onPressed: () => {Navigator.pop(context)},
                icon: SvgPicture.asset(
                  "assets/svg/x.svg",
                  color: Colors.black87,
                ))
          ]),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
