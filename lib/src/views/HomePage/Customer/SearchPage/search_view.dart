import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:ecommerce/src/helpers/colors_constant.dart';
import 'package:ecommerce/src/helpers/screen.dart';
import 'package:ecommerce/src/model/product.dart';
import 'package:ecommerce/src/views/HomePage/Customer/HomePage/ProductDetail/main_detail_product_view.dart';
import 'package:ecommerce/src/views/HomePage/Customer/HomePage/product_list_view.dart';
import 'package:ecommerce/src/widgets/card_product.dart';
import 'package:ecommerce/src/widgets/category_item.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView>
    with AutomaticKeepAliveClientMixin {
  List queryResultSet = [];
  List tempSearchStore = [];
  bool isSearch = false;
  TextEditingController textController = new TextEditingController();

  //TODO: Search function
  searching(String value) {
    if (value.length == 0) {
      setState(() {
        isSearch = false;
        queryResultSet = [];
        tempSearchStore = [];
      });
    }
    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);
    if (queryResultSet.length == 0 && value.length == 1) {
      Firestore.instance
          .collection('Products')
          .where('search_key', isEqualTo: value.substring(0, 1).toUpperCase())
          .getDocuments()
          .then((snapshot) {
        for (var document in snapshot.documents) {
          Product product = new Product(
            id: document['id'],
            productName: document['name'],
            imageList: document['image'],
            category: document['categogy'],
            sizeList: document['size'],
            colorList: document['color'],
            price: document['price'],
            salePrice: document['sale_price'],
            quantityMain: document['quantity'],
            quantity: '',
            description: document['description'],
            rating: document['rating'],
          );
          queryResultSet.add(product);
          setState(() {
            tempSearchStore = queryResultSet;
          });
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element.productName.toString().startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  //TODO: List searching result
  Widget searchingResult() {
    return Padding(
      padding: EdgeInsets.all(
        ConstScreen.setSizeHeight(30),
      ),
      child: GridView.count(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        crossAxisCount: 2,
        crossAxisSpacing: ConstScreen.setSizeHeight(30),
        mainAxisSpacing: ConstScreen.setSizeHeight(40),
        childAspectRatio: 66 / 110,
        children: tempSearchStore.map((product) {
          return ProductCard(
            productName: product.productName,
            image: product.imageList[0],
            isSoldOut: (product.quantityMain == '0'),
            price: int.parse(product.price),
            salePrice:
                (product.salePrice != '0') ? int.parse(product.salePrice) : 0,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainDetailProductView(
                    product: product,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
  //TODO: Category
  Widget category() {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        //TODO: Clothing
        ExpansionTile(
          title: Text('LAPTOP',
              style: TextStyle(
                  fontSize: FontSize.setTextSize(32),
                  fontWeight: FontWeight.w400)),
          children: <Widget>[
            CategoryItem(
              title: 'Microsoft',
              onTap: () {
                navigatorTo('Microsoft');
              },
            ),
            CategoryItem(
              title: 'Apple',
              onTap: () {
                navigatorTo('Apple');
              },
            ),
            CategoryItem(
              title: 'Dell',
              onTap: () {
                navigatorTo('Dell');
              },
            ),
            CategoryItem(
              title: 'HP',
              onTap: () {
                navigatorTo('HP');
              },
            ),
            CategoryItem(
              title: 'Asus',
              onTap: () {
                navigatorTo('Asus');
              },
            ),
            CategoryItem(
              title: 'Acer',
              onTap: () {
                navigatorTo('Acer');
              },
            ),
            CategoryItem(
              title: 'LG',
              onTap: () {
                navigatorTo('LG');
              },
            ),
            CategoryItem(
              title: 'MSI',
              onTap: () {
                navigatorTo('MSI');
              },
            ),
          ],
        ),
        //TODO: Shoes
        ExpansionTile(
          title: Text(
            'PHONE',
            style: TextStyle(
                fontSize: FontSize.setTextSize(32),
                color: kColorBlack,
                fontWeight: FontWeight.w400),
          ),
          children: <Widget>[
            CategoryItem(
              title: 'Apple',
              onTap: () {
                navigatorTo('Apple');
              },
            ),
            CategoryItem(
              title: 'Samsung',
              onTap: () {
                navigatorTo('Samsung');
              },
            ),
            CategoryItem(
              title: 'Xiaomi',
              onTap: () {
                navigatorTo('Xiaomi');
              },
            ),
            CategoryItem(
              title: 'Huawei',
              onTap: () {
                navigatorTo('Huawei');
              },
            ),
          ],
        ),
        //TODO: Accessories
        ExpansionTile(
          title: Text(
            'Tablet',
            style: TextStyle(
                fontSize: FontSize.setTextSize(32),
                color: kColorBlack,
                fontWeight: FontWeight.w400),
          ),
          children: <Widget>[
            CategoryItem(
              title: 'Apple',
              onTap: () {
                navigatorTo('Apple');
              },
            ),
            CategoryItem(
              title: 'Samsung',
              onTap: () {
                navigatorTo('Samsung');
              },
            ),
          ],
        ),
      ],
    );
  }
  //TODO: Navigator link
  void navigatorTo(String link) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductListView(
                  search: link,
                )));
  }

  @override
  Widget build(BuildContext context) {
    ConstScreen.setScreen(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // TODO: Search Bar
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: kColorBlack.withOpacity(0.6),
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: ConstScreen.setSizeHeight(15),
                    horizontal: ConstScreen.setSizeWidth(20)),
                child: TextField(
                  controller: textController,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kColorBlack.withOpacity(0.6),
                      ),
                    ),
                    hintText: 'TÌM KIẾM',
                    hintStyle: TextStyle(
                        fontSize: FontSize.s30,
                        color: kColorBlack,
                        fontWeight: FontWeight.bold),
                    // TODO: Search Button
                    suffixIcon: Icon(
                      Icons.search,
                      color: kColorBlack.withOpacity(0.8),
                      size: ConstScreen.setSizeWidth(45),
                    ),
                  ),
                  style: TextStyle(fontSize: FontSize.s30, color: kColorBlack),
                  maxLines: 1,
                  onChanged: (value) {
                    searching(value);
                    setState(() {
                      isSearch = true;
                    });
                  },
                ),
              ),
            ),
          ),
          //TODO: Category
          Expanded(
            flex: 9,
            child: (isSearch) ? searchingResult() : category(),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
