import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<WebViewScreen> {
  late final WebViewController controller;
  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ))
      ..loadRequest(
        Uri.parse('https://www.sau.edu.bd/'),
      );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('www.sau.edu.bd'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.home), // Put icon of your preference.
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
          actions: [
            PopupMenuButton(
              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
                itemBuilder: (context){
                  return [
                  const PopupMenuItem<int>(
                      value: 0,
                      child: Text("Open in browser"),
                    ),

                  ];
                },
                onSelected:(value){
                  if(value == 0){
                    _makeWebLaunch('https://www.sau.edu.bd/');
                  }
                }
            ),


          ],
        ),
        body: Stack(
          children: [
            WebViewWidget(
              controller: controller,
            ),
            if (loadingPercentage < 100)
              LinearProgressIndicator(
                value: loadingPercentage / 100.0,
              ),
          ],
        ));
  }
  Future<void> _makeWebLaunch(String email) async {
    final Uri url = Uri.parse(email);
    if(await canLaunchUrl(url)){
      if (await launchUrl(url,mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    }

  }
}