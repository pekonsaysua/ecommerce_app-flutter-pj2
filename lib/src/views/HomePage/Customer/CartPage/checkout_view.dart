import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ecommerce/link.dart';
import 'package:ecommerce/src/helpers/TextStyle.dart';
import 'package:ecommerce/src/helpers/colors_constant.dart';
import 'package:ecommerce/src/helpers/screen.dart';
import 'package:ecommerce/src/helpers/utils.dart';
import 'package:ecommerce/src/model/product.dart';
import 'package:ecommerce/src/services/stripe_payment.dart';
import 'package:ecommerce/src/views/HomePage/Customer/CartPage/checkout_controller.dart';
import 'package:ecommerce/src/views/HomePage/Customer/CartPage/payment_complete_view.dart';
import 'package:ecommerce/src/widgets/button_raised.dart';
import 'package:ecommerce/src/widgets/card_product_order.dart';
import 'package:ecommerce/src/widgets/category_item.dart';
import 'package:ecommerce/src/widgets/input_text.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:stripe_payment/stripe_payment.dart';

class ProcessingOrderView extends StatefulWidget {
  final _globalKey = new GlobalKey<ScaffoldState>();
  ProcessingOrderView({this.productList, this.total, this.uid});
  final int total;
  final List<Product> productList;
  final String uid;

  @override
  _ProcessingOrderViewState createState() => _ProcessingOrderViewState();
}

class _ProcessingOrderViewState extends State<ProcessingOrderView> {
  CheckoutController _checkoutController = new CheckoutController();
  String _receiverName = '';
  String _phoneNumber = '';
  String _address = '';
  String cardNumber = '';
  int expiryMonth;
  int expiryYear;
  String cardHolderName = '';
  String cvvCode = '';
  double discountPrice = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StripeService.init();
  }
  @override
  Widget build(BuildContext context) {
    ConstScreen.setScreen(context);
    return Scaffold(
      key: widget._globalKey,
      appBar: AppBar(
        iconTheme: IconThemeData.fallback(),
        backgroundColor: kColorWhite,
        // TODO: Quantity Items
        title: Text(
          'Thanh toán',
          style: TextStyle(
              color: kColorBlack,
              fontSize: FontSize.setTextSize(32),
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(
              top: ConstScreen.setSizeHeight(30),
              bottom: ConstScreen.setSizeHeight(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                //TODO: Shipping info
                Card(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: ConstScreen.setSizeHeight(30),
                        bottom: ConstScreen.setSizeHeight(20),
                        left: ConstScreen.setSizeHeight(40),
                        right: ConstScreen.setSizeHeight(40)),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                size: ConstScreen.setSizeHeight(40),
                              ),
                              AutoSizeText('Thông tin người nhận',
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  minFontSize: 15,
                                  style: TextStyle(
                                      fontSize: FontSize.setTextSize(34),
                                      color: kColorBlack,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: ConstScreen.setSizeHeight(20),
                        ),
                        //TODO: Name
                        StreamBuilder(
                          stream: _checkoutController.nameStream,
                          builder: (context, snapshot) {
                            return InputText(
                              title: 'Tên người nhận',
                              errorText:
                                  snapshot.hasError ? snapshot.error : '',
                              inputType: TextInputType.text,
                              onValueChange: (name) {
                                _receiverName = name;
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: ConstScreen.setSizeHeight(20),
                        ),
                        //TODO: Phone number
                        StreamBuilder(
                          stream: _checkoutController.phoneStream,
                          builder: (context, snapshot) {
                            return InputText(
                              title: 'Điện thoại',
                              errorText:
                                  snapshot.hasError ? snapshot.error : '',
                              inputType: TextInputType.number,
                              onValueChange: (phoneNumber) {
                                _phoneNumber = phoneNumber;
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: ConstScreen.setSizeHeight(20),
                        ),
                        // TODO: get Address
//                        GestureDetector(
//                          onTap: () async {
//                            Prediction p = await PlacesAutocomplete.show(
//                                context: context,
//                                apiKey:
//                                    'AIzaSyAAsiJbTpLEeB2dEPVTVWDF5HjyU2lbwAo', // Mode.fullscreen
//                                mode: Mode.fullscreen,
//                                language: "vn",
//                                components: [
//                                  new Component(Component.country, "vn")
//                                ]);
//                            if (p.description != null) {
//                              setState(() {
//                                _address = p.description;
//                              });
//                            }
//                          },
//                          child: Container(
//                            width: double.infinity,
//                            decoration: BoxDecoration(
//                              border: Border.all(
//                                  color: kColorBlack.withOpacity(0.3)),
//                            ),
//                            child: Padding(
//                              padding: EdgeInsets.only(
//                                  top: ConstScreen.setSizeHeight(20),
//                                  bottom: ConstScreen.setSizeHeight(20),
//                                  left: ConstScreen.setSizeHeight(20),
//                                  right: ConstScreen.setSizeHeight(20)),
//                              child: AutoSizeText('Address: ' + _address,
//                                  textAlign: TextAlign.start,
//                                  maxLines: 2,
//                                  minFontSize: 15,
//                                  style: TextStyle(
//                                      fontSize: FontSize.setTextSize(30),
//                                      color: kColorBlack,
//                                      fontWeight: FontWeight.normal)),
//                            ),
//                          ),
//                        ),
                        //TODO: Error address check
                        StreamBuilder(
                          stream: _checkoutController.addressStream,
                          builder: (context, snapshot) {
                            return InputText(
                              title: 'Địa chỉ',
                              errorText:
                                  snapshot.hasError ? snapshot.error : '',
                              onValueChange: (address) {
                                _address = address;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                //TODO: Your Order
                Card(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: ConstScreen.setSizeHeight(30),
                        bottom: ConstScreen.setSizeHeight(20),
                        left: ConstScreen.setSizeHeight(40),
                        right: ConstScreen.setSizeHeight(40)),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.list,
                                size: ConstScreen.setSizeHeight(40),
                              ),
                              SizedBox(
                                width: ConstScreen.setSizeWidth(5),
                              ),
                              AutoSizeText(
                                'Đơn hàng của bạn',
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                minFontSize: 15,
                                style: TextStyle(
                                    fontSize: FontSize.setTextSize(34),
                                    color: kColorBlack,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: ConstScreen.setSizeWidth(20),
                        ),
                        //TODO: list order item
                        Column(
                          children: widget.productList.map((product) {
                            return ProductOrderDetail(
                              name: product.productName,
                              price: (product.salePrice == '0')
                                  ? product.price
                                  : product.salePrice,
                              quantity: product.quantity,
                              color: Color(product.color),
                              size: product.size,
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: ConstScreen.setSizeWidth(20),
                        ),
                        //TODO: Sub total
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: AutoSizeText(
                                'Thành tiền',
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                minFontSize: 15,
                                style: TextStyle(
                                    fontSize: FontSize.setTextSize(26),
                                    color: kColorBlack,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: AutoSizeText(
                                Util.intToMoneyType(widget.total) + ' VND',
                                textAlign: TextAlign.end,
                                maxLines: 2,
                                minFontSize: 15,
                                style: TextStyle(
                                    fontSize: FontSize.setTextSize(30),
                                    color: kColorBlack,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        //TODO: Shipping
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: AutoSizeText(
                                'Phí ship',
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                minFontSize: 15,
                                style: TextStyle(
                                    fontSize: FontSize.setTextSize(26),
                                    color: kColorBlack,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: AutoSizeText(
                                (widget.total > 300000)
                                    ? '+0 VND'
                                    : '+20,000 VND',
                                textAlign: TextAlign.end,
                                maxLines: 2,
                                minFontSize: 15,
                                style: TextStyle(
                                    fontSize: FontSize.setTextSize(30),
                                    color: kColorBlack,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        //TODO: TOTAL
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: AutoSizeText(
                                'Tổng cộng',
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                minFontSize: 15,
                                style: TextStyle(
                                    fontSize: FontSize.setTextSize(30),
                                    color: kColorBlack,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: AutoSizeText(
                                Util.intToMoneyType((widget.total > 300000)
                                        ? widget.total - discountPrice.floor()
                                        : widget.total +
                                            20000 -
                                            discountPrice.floor()) +
                                    ' VND',
                                textAlign: TextAlign.end,
                                maxLines: 2,
                                minFontSize: 15,
                                style: TextStyle(
                                    fontSize: FontSize.setTextSize(34),
                                    color: kColorBlack,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        //TODO: Error quantity check
                        StreamBuilder(
                          stream: _checkoutController.quantityStream,
                          builder: (context, snapshot) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: ConstScreen.setSizeHeight(10),
                                  left: ConstScreen.setSizeHeight(22),
                                ),
                                child: AutoSizeText(
                                    snapshot.hasError ? snapshot.error : '',
                                    textAlign: TextAlign.start,
                                    maxLines: 20,
                                    minFontSize: 12,
                                    style: TextStyle(
                                        fontSize: FontSize.setTextSize(20),
                                        color: snapshot.hasError
                                            ? kColorRed
                                            : kColorBlack,
                                        fontWeight: FontWeight.normal)),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        child: StreamBuilder(
            stream: _checkoutController.btnLoadingStream,
            builder: (context, snapshot) {
              return CusRaisedButton(
                title: 'Thanh toán',
                isDisablePress: snapshot.hasData ? snapshot.data : true,
                height: ConstScreen.setSizeHeight(150),
                backgroundColor: Colors.orangeAccent.shade700,
                onPress: () async {
                  bool isValidate = await _checkoutController.onValidate(
                    name: _receiverName,
                    phoneNumber: _phoneNumber,
                    address: _address,
                    productList: widget.productList,
                    total: widget.total.toString(),
                  );

                  if (isValidate) {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Card(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: ConstScreen.setSizeHeight(30),
                                  bottom: ConstScreen.setSizeHeight(20),
                                  left: ConstScreen.setSizeHeight(40),
                                  right: ConstScreen.setSizeHeight(40)),
                              child: Column(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.payment,
                                          size: ConstScreen.setSizeHeight(40),
                                        ),
                                        SizedBox(
                                          width: ConstScreen.setSizeWidth(5),
                                        ),
                                        AutoSizeText(
                                          'PAYMENT:',
                                          textAlign: TextAlign.start,
                                          maxLines: 2,
                                          minFontSize: 15,
                                          style: TextStyle(
                                              fontSize:
                                                  FontSize.setTextSize(34),
                                              color: kColorBlack,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: ConstScreen.setSizeWidth(20),
                                  ),
                                  //TODO: Pay via new card
                                  CusRaisedButton(
                                    title: 'Thanh toán bằng thẻ mới',
                                    backgroundColor: Colors.deepOrangeAccent,
                                    onPress: () async {
                                      String orderId = DateTime.now()
                                          .millisecondsSinceEpoch
                                          .toString();
                                      var response = await StripeService
                                          .paymentWithNewCard(
                                              amount: (((widget.total >= 300000)
                                                          ? 0
                                                          : 20000) +
                                                      widget.total -
                                                      discountPrice.floor())
                                                  .toString(),
                                              currency: 'VND',
                                              orderId: orderId);
                                      // TODO: Create Order
                                      if (response.success) {
                                        _checkoutController.onPayment(
                                            name: _receiverName,
                                            phoneNumber: _phoneNumber,
                                            address: _address,
                                            productList: widget.productList,
                                            total: widget.total.toString(),
                                            clientSecret: response.clientSecret,
                                            orderId: orderId,
                                            paymentMethodId:
                                                response.paymentMethodId,
                                            discountPrice: discountPrice
                                                .floor()
                                                .toString(),
                                        );
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PaymentCompleteView(
                                                      totalPrice: widget.total,
                                                    )));
                                      } else {
                                        Navigator.pop(context);
                                        widget._globalKey.currentState
                                            .showSnackBar(SnackBar(
                                          content: Text(response.clientSecret),
                                          duration: Duration(seconds: 10),
                                        ));
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: ConstScreen.setSizeWidth(15),
                                  ),
                                  //TODO: Payment via existing card
                                  CusRaisedButton(
                                    title: 'Thanh toán bằng thẻ có sẵn',
                                    backgroundColor: Colors.deepOrangeAccent,
                                    onPress: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => Dialog(
                                                child: StreamBuilder<
                                                    QuerySnapshot>(
                                                  stream: Firestore.instance
                                                      .collection('Cards')
                                                      .where('uid',
                                                          isEqualTo: widget.uid)
                                                      .snapshots(),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<
                                                                  QuerySnapshot>
                                                              snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Column(
                                                        children: <Widget>[
                                                          SizedBox(
                                                            height: ConstScreen
                                                                .setSizeHeight(
                                                                    15),
                                                          ),
                                                          AutoSizeText(
                                                            'Thẻ ngân hàng',
                                                            textAlign: TextAlign
                                                                .center,
                                                            maxLines: 2,
                                                            minFontSize: 15,
                                                            style: TextStyle(
                                                                fontSize: FontSize
                                                                    .setTextSize(
                                                                        34),
                                                                color:
                                                                    kColorBlack,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          SizedBox(
                                                            height: ConstScreen
                                                                .setSizeHeight(
                                                                    15),
                                                          ),
                                                          (snapshot
                                                                      .data
                                                                      .documents
                                                                      .length !=
                                                                  0)
                                                              ? ListView(
                                                                  shrinkWrap:
                                                                      true,
                                                                  scrollDirection:
                                                                      Axis.vertical,
                                                                  children: snapshot
                                                                      .data
                                                                      .documents
                                                                      .map((DocumentSnapshot
                                                                          document) {
                                                                    return Center(
                                                                      child:
                                                                          GestureDetector(
                                                                        //TODO: Payment with exist card
                                                                        onTap:
                                                                            () async {
                                                                          ProgressDialog
                                                                              dialog =
                                                                              new ProgressDialog(context);
                                                                          dialog.style(
                                                                              message: 'Please wait...');
                                                                          dialog
                                                                              .show();
                                                                          //TODO: Show dialog loading
                                                                          cardNumber =
                                                                              document['cardNumber'];
                                                                          expiryMonth =
                                                                              document['expiryMonth'];
                                                                          expiryYear =
                                                                              document['expiryYear'];
                                                                          cardHolderName =
                                                                              document['cardHolderName'];
                                                                          cvvCode =
                                                                              document['cvvCode'];
                                                                          CreditCard
                                                                              stripeCard =
                                                                              CreditCard(
                                                                            number:
                                                                                cardNumber,
                                                                            expMonth:
                                                                                expiryMonth,
                                                                            expYear:
                                                                                expiryYear,
                                                                          );
                                                                          String
                                                                              orderId =
                                                                              DateTime.now().millisecondsSinceEpoch.toString();
                                                                          var response = await StripeService.paymentWithExistCard(
                                                                              amount: (((widget.total >= 300000) ? 0 : 20000) + widget.total - discountPrice.floor()).toString(),
                                                                              currency: 'VND',
                                                                              card: stripeCard,
                                                                              orderId: orderId);
                                                                          dialog
                                                                              .hide();
                                                                          // TODO: Create Order
                                                                          if (response
                                                                              .success) {
                                                                            _checkoutController.onPayment(
                                                                                name: _receiverName,
                                                                                phoneNumber: _phoneNumber,
                                                                                address: _address,
                                                                                productList: widget.productList,
                                                                                total: widget.total.toString(),
                                                                                orderId: orderId,
                                                                                clientSecret: response.clientSecret,
                                                                                paymentMethodId: response.paymentMethodId,
                                                                                discountPrice: discountPrice.floor().toString()
                                                                                );
                                                                            //TODO: Payment success
                                                                            Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                    builder: (context) => PaymentCompleteView(
                                                                                          totalPrice: widget.total,
                                                                                        )));
                                                                          } else {
                                                                            Navigator.pop(context);
                                                                            Navigator.pop(context);
                                                                            widget._globalKey.currentState.showSnackBar(SnackBar(
                                                                              content: Text(response.clientSecret),
                                                                              duration: Duration(seconds: 10),
                                                                            ));
                                                                          }
                                                                        },
                                                                        child:
                                                                            CreditCardWidget(
                                                                          height:
                                                                              ConstScreen.setSizeHeight(340),
                                                                          width:
                                                                              ConstScreen.setSizeWidth(520),
                                                                          textStyle: TextStyle(
                                                                              fontSize: FontSize.setTextSize(34),
                                                                              color: kColorWhite,
                                                                              fontWeight: FontWeight.bold),
                                                                          cardNumber:
                                                                              document['cardNumber'],
                                                                          expiryDate:
                                                                              '${document['expiryMonth'].toString()} / ${document['expiryYear'].toString()}',
                                                                          cardHolderName:
                                                                              document['cardHolderName'],
                                                                          cvvCode:
                                                                              document['cvvCode'],
                                                                          showBackView:
                                                                              false,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }).toList(),
                                                                )
                                                              : Container(
                                                                  height: ConstScreen
                                                                      .setSizeHeight(
                                                                          800),
                                                                  width: ConstScreen
                                                                      .setSizeWidth(
                                                                          520),
                                                                  child: Stack(
                                                                    children: <
                                                                        Widget>[
                                                                      Positioned(
                                                                        top: ConstScreen.setSizeWidth(
                                                                            350),
                                                                        left: ConstScreen.setSizeHeight(
                                                                            120),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              ConstScreen.setSizeWidth(324),
                                                                          height:
                                                                              ConstScreen.setSizeHeight(170),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            image:
                                                                                DecorationImage(
                                                                              image: AssetImage(KImageAddress + 'noCreditCard.png'),
                                                                              fit: BoxFit.fill,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Positioned(
                                                                        top: ConstScreen.setSizeHeight(
                                                                            650),
                                                                        left: ConstScreen.setSizeWidth(
                                                                            100),
                                                                        child:
                                                                            Text(
                                                                          'Không tìm thấy thẻ',
                                                                          style: kBoldTextStyle.copyWith(
                                                                              color: kColorBlack.withOpacity(0.8),
                                                                              fontSize: FontSize.s36,
                                                                              fontWeight: FontWeight.w600),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                        ],
                                                      );
                                                    } else {
                                                      return Center(
                                                          child:
                                                              CircularProgressIndicator());
                                                    }
                                                  },
                                                ),
                                              ));
                                    },
                                  ),
                                  SizedBox(
                                    height: ConstScreen.setSizeWidth(15),
                                  ),
                                  CusRaisedButton(
                                    title: 'Hủy',
                                    backgroundColor: kColorBlack,
                                    onPress: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                },
              );
            }),
      ),
    );
  }
}
