import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/src/helpers/screen.dart';
import 'package:ecommerce/src/widgets/button_tap.dart';
import 'package:ecommerce/src/widgets/icon_shop.dart';

import '../../link.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ConstScreen.setScreen(context);
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(KImageAddress + 'welcome_wall.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(.3),
                  Colors.black.withOpacity(.1),
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  ConstScreen.setSizeHeight(20),
                  ConstScreen.setSizeHeight(20),
                  ConstScreen.setSizeHeight(20),
                  ConstScreen.setSizeHeight(90)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    flex: 8,
                    child: IconInstacop(
                      textSize: FontSize.setTextSize(80),
                    ),
                  ),
                  SizedBox(
                    height: ConstScreen.setSizeHeight(100),
                  ),
                  new ButtonTap(
                    text: 'Đăng nhập / Đăng ký',
                    isSelected: true,
                    function: () {
                      Navigator.pushNamed(context, 'register_screen');
                    },
                  ),
                  SizedBox(
                    height: ConstScreen.setSizeHeight(25),
                  ),
                  new ButtonTap(
                    text: "Khách",
                    isSelected: false,
                    function: () {
                      Navigator.pushNamed(context, 'customer_home_screen');
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
