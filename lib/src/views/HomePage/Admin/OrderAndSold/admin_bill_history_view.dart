import 'package:flutter/material.dart';
import 'package:ecommerce/src/helpers/TextStyle.dart';
import 'package:ecommerce/src/helpers/colors_constant.dart';
import 'package:ecommerce/src/helpers/screen.dart';
import 'package:ecommerce/src/views/HomePage/Customer/ProfilePage/OrderAndBill/order_and_bill_view.dart';

class AdminBillHistoryView extends StatefulWidget {
  @override
  _AdminBillHistoryViewState createState() => _AdminBillHistoryViewState();
}

class _AdminBillHistoryViewState extends State<AdminBillHistoryView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ConstScreen.setScreen(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData.fallback(),
        backgroundColor: kColorWhite,
        // TODO: Quantity Items
        title: Text(
          'Quản lý lịch sử đơn hàng',
          style: TextStyle(
              color: kColorBlack,
              fontSize: FontSize.setTextSize(32),
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        bottom: TabBar(
          unselectedLabelColor: Colors.black.withOpacity(0.5),
          labelColor: Colors.lightBlueAccent,
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.check_circle,
                size: ConstScreen.setSizeHeight(30),
              ),
              child: Text(
                'Hoàn thành',
                style: kBoldTextStyle.copyWith(fontSize: FontSize.s28),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.cancel,
                size: ConstScreen.setSizeHeight(30),
              ),
              child: Text(
                'Huỷ bỏ',
                style: kBoldTextStyle.copyWith(fontSize: FontSize.s28),
              ),
            )
          ],
        ),
      ),
      body: TabBarView(
        children: [
          OrderAndBillView(
            status: 'Completed',
            isAdmin: true,
          ),
          OrderAndBillView(
            status: 'Canceled',
            isAdmin: true,
          ),
        ],
        controller: _tabController,
      ),
    );
  }
}
