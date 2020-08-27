import 'package:flutter/material.dart';
import 'package:ecommerce/src/helpers/screen.dart';
import 'package:ecommerce/src/helpers/shared_preferrence.dart';
import 'package:ecommerce/src/widgets/icon_instacop.dart';
import 'package:flutter/cupertino.dart';
import '../../link.dart';


class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    delay().then((viewLink) {
      Navigator.pushNamed(context, viewLink);
    });
  }

  Future<String> delay() async {
    String viewLink = 'customer_home_screen';
    StorageUtil.getIsLogging().then((result) async {
      if (result == null) {
        viewLink = 'customer_home_screen';
      } else {
        String type = await StorageUtil.getAccountType();
        if (type == 'admin') {
          viewLink = 'admin_home_screen';
        } else {
          viewLink = 'customer_home_screen';
        }
      }
    });
    await Future.delayed(Duration(seconds: 2));

    return viewLink;
  }

  @override
  Widget build(BuildContext context) {
    ConstScreen.setScreen(context);
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: double.infinity,
          //color: Colors.black26,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(KImageAddress + 'welcome_wall.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new IconInstacop(
                textSize: FontSize.setTextSize(80),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
