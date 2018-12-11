// import 'package:flutter/material.dart';
// // import 'package:flutter_html_view/flutter_html_view.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// import 'package:cat_dog/modules/dashboard/actions.dart';

// class ViewComponent extends StatefulWidget {
//   final dynamic news;
//   const ViewComponent({
//     Key key,
//     this.news
//   }) : super(key: key);

//   @override
//   _ViewComponentState createState() => new _ViewComponentState();
// }
// class _ViewComponentState extends State<ViewComponent> {
//   String html = '';
//   final flutterWebviewPlugin = new FlutterWebviewPlugin();
//   @override
//   void initState() {
//     super.initState();
//     getDefailNews(widget.news['url']).then((result) {
//       print(result);
//       // setState(() {
//       //   html = result;
//       // });
//       flutterWebviewPlugin.launch(new Uri.dataFromString('', mimeType: 'text/html', parameters: { 'charset': 'utf-8' }).toString(), hidden: false);
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return new Center(
//       // child: new SingleChildScrollView(
//       //   child: new Center(
//       //     child: new HtmlView(
//       //       data: html,
//       //       baseURL: "", // optional, type String
//       //       onLaunchFail: (url) { // optional, type Function
//       //         print("launch $url failed");
//       //       }
//       //     )
//       //   ),
//       // )
//       child: new WebviewScaffold(
//           url: new Uri.dataFromString('', mimeType: 'text/html', parameters: { 'charset': 'utf-8' }).toString(),
//           appBar: new AppBar(
//             title: Text(widget.news['heading']),
//           ),
//           withZoom: true,
//           withLocalStorage: true,
//           hidden: false,
//           initialChild: Container(
//             child: const Center(
//               child: Text('Waiting.....'),
//             ),
//           ),
//         ),
//     );
//   }

// }