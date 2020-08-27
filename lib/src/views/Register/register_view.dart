import 'package:flutter/material.dart';
import 'package:ecommerce/src/helpers/colors_constant.dart';
import 'package:ecommerce/src/helpers/screen.dart';
import 'package:ecommerce/src/views/Register/SignIn/sign_in_form.dart';
import 'package:ecommerce/src/views/Register/SignUp/sign_up_form.dart';
import 'package:ecommerce/src/widgets/button_raised.dart';

class RegisterView extends StatefulWidget {


  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool _isSignIn = true;
  @override
  Widget build(BuildContext context) {
    ConstScreen.setScreen(context);
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kColorBlack,
        ),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.black,
              Colors.black87,
            ], begin: Alignment.topCenter),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: ConstScreen.setSizeHeight(65),
                        horizontal: ConstScreen.setSizeHeight(50)),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            _isSignIn ? 'Đăng nhập' : 'Đăng ký',
                            style: TextStyle(
                                fontSize: FontSize.setTextSize(60),
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _isSignIn
                              ? SignInView()
                              : SignUpView(
                                  typeAccount: 'customer',
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          //TODO: Button Change SignIn <-> SignUp
                          CusRaisedButton(
                            backgroundColor: Colors.grey.shade100,
                            title: _isSignIn ? 'ĐĂNG KÝ' : 'ĐĂNG NHẬP',
                            onPress: () {
                              setState(() {
                                _isSignIn = !_isSignIn;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
