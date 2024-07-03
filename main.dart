
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData.dark(),
    );
  }
}

class InternetConnectivityWidget extends StatefulWidget {
  const InternetConnectivityWidget({super.key});

  @override
  _InternetConnectivityWidgetState createState() =>
      _InternetConnectivityWidgetState();
}

class _InternetConnectivityWidgetState
    extends State<InternetConnectivityWidget> {
  var connectivityResult = ConnectivityResult.none;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        connectivityResult = result;
      });
      showToast();
    });
  }

  Future<void> initConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      this.connectivityResult = connectivityResult;
    });
  }

  void showToast() {
    String message = 'Internet is ';
    if (connectivityResult == ConnectivityResult.none) {
      message += 'not available.';
    } else {
      message += 'available.';
    }
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text('Internet Connectivity: $connectivityResult');
  }
}
