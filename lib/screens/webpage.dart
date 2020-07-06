import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

final Set<JavascriptChannel> jsChannels = [
  JavascriptChannel(
      name: 'Print',
      onMessageReceived: (JavascriptMessage message) {
        print(message.message);
      }),
].toSet();

var url;

class WebPage extends StatefulWidget {
  final URL;

  WebPage({this.URL}) {
    url = URL;
  }

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: url,
      javascriptChannels: jsChannels,
      mediaPlaybackRequiresUserGesture: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          url.toString(),
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 15.0,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                flutterWebViewPlugin.goBack();
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              onPressed: () {
                flutterWebViewPlugin.goForward();
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.autorenew,
                color: Colors.white,
              ),
              onPressed: () {
                flutterWebViewPlugin.reload();
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () {
                flutterWebViewPlugin.close();
                flutterWebViewPlugin.dispose();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
