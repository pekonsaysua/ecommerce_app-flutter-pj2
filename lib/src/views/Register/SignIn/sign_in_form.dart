import 'package:ecommerce/src/helpers/shared_preferrence.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/src/helpers/TextStyle.dart';
import 'package:ecommerce/src/helpers/colors_constant.dart';
import 'package:ecommerce/src/helpers/screen.dart';
import 'package:ecommerce/src/views/Register/SignIn/sign_in_controller.dart';
import 'package:ecommerce/src/widgets/button_raised.dart';
import 'package:ecommerce/src/widgets/input_text.dart';
import 'package:path/path.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  bool _isAdmin = false;
  SignInController signInController = new SignInController();
  String _email = '';
  String _password = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        //TODO: Username
        StreamBuilder(
          stream: signInController.emailStream,
          builder: (context, snapshot) => InputText(
            title: 'Email',
            errorText: snapshot.hasError ? snapshot.error : '',
            onValueChange: (value) {
              _email = value;
            },
          ),
        ),
        SizedBox(
          height: ConstScreen.setSizeHeight(18),
        ),
        //TODO: Password
        StreamBuilder(
          stream: signInController.passwordStream,
          builder: (context, snapshot) => InputText(
            title: 'Mật khẩu',
            isPassword: true,
            errorText: snapshot.hasError ? snapshot.error : '',
            onValueChange: (value) {
              _password = value;
            },
          ),
        ),
        //TODO: Button Sign In
        SizedBox(
          height: ConstScreen.setSizeHeight(20),
        ),

        SizedBox(
          height: ConstScreen.setSizeHeight(25),
        ),
        StreamBuilder(
            stream: signInController.btnLoadingStream,
            builder: (context, snapshot) {
              return CusRaisedButton(
                backgroundColor: kColorBlack,
                title: 'ĐĂNG NHẬP',
                isDisablePress: snapshot.hasData ? snapshot.data : true,
                onPress: () async {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  var result = await signInController.onSubmitSignIn(
                      email: _email, password: _password, isAdmin: _isAdmin);
                  print('Screen  ' + result.toString());

                  var route = ModalRoute.of(context);

                  if(route!=null){
                    print(route.settings.name);
                  }

                  if (result != '') {
                    //if(result == 'admin_home_screen') {
                      Navigator.of(context).pushNamedAndRemoveUntil(result, ModalRoute.withName('splash_screen'),);
                    //Navigator.pushNamedAndRemoveUntil(context, result, (Route<dynamic> route) => false);
                      //Navigator.pushNamed(context, result);
                      SignInController().dispose();
                    //}
                    //else {
                      //Navigator.pop(context,StorageUtil.setIsLogging(true));
                      //SignInController().dispose();
                    //}

                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      backgroundColor: kColorWhite,
                      content: Row(
                        children: <Widget>[
                          Icon(
                            Icons.error,
                            color: kColorRed,
                            size: ConstScreen.setSizeWidth(50),
                          ),
                          SizedBox(
                            width: ConstScreen.setSizeWidth(20),
                          ),
                          Expanded(
                            child: Text(
                              'Đăng nhập thất bại',
                              style: kBoldTextStyle.copyWith(
                                  fontSize: FontSize.s28),
                            ),
                          )
                        ],
                      ),
                    ));
                  }
                },
              );
            })
      ],
    );
  }
}
