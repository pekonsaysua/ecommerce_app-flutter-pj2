import 'package:flutter/material.dart';
import 'package:ecommerce/routes.dart';

//TODO: device review
//void main() => runApp(
//      DevicePreview(
//        builder: (context) => MyApp(),
//      ),
//    );

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      locale: DevicePreview.of(context).locale,
//      builder: DevicePreview.appBuilder,
      initialRoute: initialRoute,
      routes: routes,
    );
  }
}
