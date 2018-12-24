import 'package:flutter/material.dart';
import 'package:cat_dog/common/components/SpinLoading.dart';

class LoadingPage extends StatefulWidget {
  final Widget component;
  final bool loading;
  const LoadingPage({
    Key key,
    this.component,
    this.loading
  }) : super(key: key);

  @override
  _LoadingPageState createState() => new _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  _LoadingPageState({Key key});

  @override
  Widget build(BuildContext context) {
    if (widget.loading) {
      return new SpinLoading();
    }
    return widget.component;
  }
}