import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/src/helpers/colors_constant.dart';
import 'package:ecommerce/src/helpers/screen.dart';
import 'package:ecommerce/src/helpers/shared_preferrence.dart';
import 'package:ecommerce/src/views/HomePage/Customer/ProfilePage/Detail/detail_user_profile_views.dart';
import 'package:ecommerce/src/widgets/button_raised.dart';

import '../../../../helpers/colors_constant.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with AutomaticKeepAliveClientMixin {
  String uid = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StorageUtil.getUid().then((onValue) {
      uid = onValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    ConstScreen.setScreen(context);
    return Container(
      color: kColorWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //TODO: Detail
          CusRaisedButton(
            title: 'Chi tiết',
            backgroundColor: kColorWhite,
            height: 100,
            onPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailProfileView(
                            uid: uid,
                          )));
            },
          ),
          //TODO: Change password
          CusRaisedButton(
            title: 'Đổi mật khẩu',
            backgroundColor: kColorWhite,
            height: 100,
            onPress: () {
              Navigator.pushNamed(context, 'customer_change_password_screen');
            },
          ),
          //TODO: Order and bill
          CusRaisedButton(
            title: 'Lịch sử đơn hàng',
            backgroundColor: kColorWhite,
            height: 100,
            onPress: () {
              Navigator.pushNamed(context, 'customer_order_history_screen');
            },
          ),
          //TODO: Bank Account
          CusRaisedButton(
            title: 'Thẻ ngân hàng',
            backgroundColor: kColorWhite,
            height: 100,
            onPress: () {
              Navigator.pushNamed(context, 'custommer_bank_account_screen');
            },
          ),
          // TODO: Sign Out
          CusRaisedButton(
            title: 'Đăng xuất',
            backgroundColor: kColorWhite,
            height: 100,
            onPress: () {
              showAlertDialog(context);
            },
          ),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Không"),
      onPressed:  () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Đồng ý"),
      onPressed:  () {
        StorageUtil.clear();
        Navigator.pushNamedAndRemoveUntil(context, 'splash_screen', (Route<dynamic> route) => false);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("Bạn có chắc chắn muốn đăng xuất?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
