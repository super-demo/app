import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MiniAppPage extends StatefulWidget {
  const MiniAppPage({super.key});

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
        Uri.parse('https://flutter.dev'),
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
