import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/src/helpers/TextStyle.dart';
import 'package:ecommerce/src/helpers/colors_constant.dart';
import 'package:ecommerce/src/helpers/screen.dart';
import 'package:ecommerce/src/helpers/utils.dart';
import 'package:ecommerce/src/model/orderInfo.dart';
import 'package:ecommerce/src/widgets/card_product_order.dart';
import 'package:ecommerce/src/widgets/widget_title.dart';

class OrderInfoView extends StatefulWidget {
  OrderInfoView({this.id, this.orderInfo, this.descriptionCancel = ' '});
  final OrderInfo orderInfo;
  final String id;
  final String descriptionCancel;
  @override
  _OrderInfoViewState createState() => _OrderInfoViewState();
}

class _OrderInfoViewState extends State<OrderInfoView> {
  @override
  Widget build(BuildContext context) {
    ConstScreen.setScreen(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Thông tin đơn hàng',
          style: kBoldTextStyle.copyWith(
            fontSize: FontSize.setTextSize(32),
          ),
        ),
        backgroundColor: kColorWhite,
        iconTheme: IconThemeData.fallback(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: ConstScreen.setSizeHeight(25),
        ),
        child: ListView(
          children: <Widget>[
            //TODO: Main Info
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ConstScreen.setSizeWidth(25)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  //TODO: Order ID
                  TitleWidget(
                    title: 'ID',
                    content: widget.id,
                  ),
                  TitleWidget(
                    title: 'Thời gian',
                    content: widget.orderInfo.createAt,
                  ),
                  TitleWidget(
                    title: 'Khách hàng',
                    content: widget.orderInfo.customerName,
                  ),
                  TitleWidget(
                    title: 'Người nhận',
                    content: widget.orderInfo.receiverName,
                  ),
                  TitleWidget(
                    title: 'Trạng thái',
                    content: widget.orderInfo.status,
                  ),
                  TitleWidget(
                    title: 'Giá tiền',
                    content:
                        '${Util.intToMoneyType(int.parse(widget.orderInfo.total) + int.parse(widget.orderInfo.shipping) )} VND',
                  ),
                  TitleWidget(
                    title: 'Phí ship',
                    content:
                        '+${Util.intToMoneyType(int.parse(widget.orderInfo.shipping))} VND',
                  ),
                  // TODO: Err total 200,000
                  Card(
                    child: TitleWidget(
                        title: 'Tổng cộng',
                        content: '${widget.orderInfo.total} VND'),
                  ),
                ],
              ),
            ),
            //TODO: Cancelled Order
            (widget.descriptionCancel != ' ')
                ? Container(
                    color: kColorLightGrey,
                    height: ConstScreen.setSizeHeight(70),
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: ConstScreen.setSizeWidth(30)),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          'Đơn hàng đã bị huỷ!',
                          maxLines: 1,
                          minFontSize: 10,
                          style: kBoldTextStyle.copyWith(
                              fontSize: FontSize.setTextSize(32),
                              color: kColorRed),
                        ),
                      ),
                    ),
                  )
                : Container(),

            (widget.descriptionCancel != ' ')
                ? Padding(
                    padding: EdgeInsets.only(
                        top: ConstScreen.setSizeHeight(10),
                        left: ConstScreen.setSizeHeight(27)),
                    child: AutoSizeText(
                      widget.descriptionCancel,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      minFontSize: 10,
                      style: kBoldTextStyle.copyWith(
                          fontSize: FontSize.s28, color: kColorBlack),
                    ),
                  )
                : Container(),
            SizedBox(
              height: ConstScreen.setSizeHeight(15),
            ),
            Container(
              color: kColorLightGrey,
              height: ConstScreen.setSizeHeight(70),
              child: Padding(
                padding: EdgeInsets.only(left: ConstScreen.setSizeWidth(30)),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    'Chi tiết sản phẩm',
                    maxLines: 1,
                    minFontSize: 10,
                    style: kBoldTextStyle.copyWith(
                        fontSize: FontSize.setTextSize(32), color: kColorBlue),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: ConstScreen.setSizeHeight(15),
            ),
            //TODO: List Product
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('Orders')
                  .document(widget.orderInfo.subId)
                  .collection(widget.orderInfo.id)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                      return ProductOrderDetail(
                        name: document['name'],
                        price: document['price'],
                        quantity: document['quantity'],
                        color: Color(document['color']),
                        size: document['size'],
                      );
                    }).toList(),
                  );
                } else {
                  return Container();
                }
              },
            ),

            //TODO: Phone number
            Container(
              color: kColorLightGrey,
              height: ConstScreen.setSizeHeight(70),
              child: Padding(
                padding: EdgeInsets.only(left: ConstScreen.setSizeWidth(30)),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    'Số điện thoại',
                    maxLines: 1,
                    minFontSize: 10,
                    style: kBoldTextStyle.copyWith(
                        fontSize: FontSize.setTextSize(32), color: kColorBlue),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: ConstScreen.setSizeHeight(10),
                  left: ConstScreen.setSizeHeight(27)),
              child: AutoSizeText(
                widget.orderInfo.phone,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                minFontSize: 10,
                style: kBoldTextStyle.copyWith(
                    fontSize: FontSize.s30, color: kColorBlack),
              ),
            ),
            //TODO: Shipping Address
            Container(
              color: kColorLightGrey,
              height: ConstScreen.setSizeHeight(70),
              child: Padding(
                padding: EdgeInsets.only(left: ConstScreen.setSizeWidth(30)),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    'Địa chỉ giao hàng',
                    maxLines: 1,
                    minFontSize: 10,
                    style: kBoldTextStyle.copyWith(
                        fontSize: FontSize.setTextSize(32), color: kColorBlue),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                  top: ConstScreen.setSizeHeight(10),
                  left: ConstScreen.setSizeHeight(27)),
              child: AutoSizeText(
                widget.orderInfo.address,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                minFontSize: 10,
                style: kBoldTextStyle.copyWith(
                    fontSize: FontSize.s30, color: kColorBlack),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
