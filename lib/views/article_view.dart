import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter_share/flutter_share.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String postUrl;
  ArticleView({@required this.postUrl});

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  // Future<void> share() async {
  //   await FlutterShare.share(
  //     title: 'Share link',
  //     text: 'Share link',
  //     linkUrl: widget.postUrl,
  //     chooserTitle: 'Share with',
  //   );
  // }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    // final RenderBox box = context.findRenderObject();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color:Colors.black),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "News",
              style: TextStyle(
                  color: Colors.blueGrey, fontWeight: FontWeight.w600),
            ),
            Text(
              "++",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),
        actions: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    share(context, widget.postUrl);
                  }))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl: widget.postUrl,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ),
      ),
    );
  }

  share(BuildContext context, String url) {
    final RenderBox box = context.findRenderObject();
    Share.share(url,
        subject: 'Share With',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
