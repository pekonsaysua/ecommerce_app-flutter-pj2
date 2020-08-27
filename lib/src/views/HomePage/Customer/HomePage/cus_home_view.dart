import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/src/helpers/screen.dart';
import 'package:ecommerce/src/views/HomePage/Customer/HomePage/product_list_view.dart';
import 'package:ecommerce/src/widgets/banner.dart';
import 'package:ecommerce/src/widgets/icon_instacop.dart';

class CustomerHomePageView extends StatefulWidget {
  @override
  _CustomerHomePageViewState createState() => _CustomerHomePageViewState();
}

class _CustomerHomePageViewState extends State<CustomerHomePageView>
    with AutomaticKeepAliveClientMixin {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    ConstScreen.setScreen(context);
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        // Banner Slider
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1.0,
            enableInfiniteScroll: false,
            scrollDirection: Axis.vertical,
            initialPage: 0,
          ),
          items: <Widget>[
            CustomBanner(
              title: 'WELCOME',
              description:'',
              image: 'mouse.jpg',
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductListView(
                              search: '',
                            )));
              },
            ),
          ],
        ),
        // Logo
        Positioned(
          top: 0,
          left: ConstScreen.setSizeWidth(255),
          child: IconInstacop(
            textSize: FontSize.setTextSize(60),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
