import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ecommerce/src/helpers/TextStyle.dart';
import 'package:ecommerce/src/helpers/colors_constant.dart';
import 'package:ecommerce/src/helpers/screen.dart';
import 'package:ecommerce/src/helpers/utils.dart';
import 'package:ecommerce/src/widgets/box_info.dart';
import 'package:ecommerce/src/widgets/widget_title.dart';

class AdminProductCard extends StatelessWidget {
  AdminProductCard(
      {this.productName = '',
      this.productSizeList,
      this.productColorList,
      this.productPrice = 0,
      this.productImage = '',
      this.productSalePrice = 0,
      this.category = '',
      this.createAt = '',
      this.quantity = '1',
      this.onClose,
      this.onEdit,
      this.onComment});
  final String productName;
  final List productColorList;
  final List productSizeList;
  final int productPrice;
  final int productSalePrice;
  final String productImage;
  final String quantity;
  final String category;
  final String createAt;
  final Function onClose;
  final Function onEdit;
  final Function onComment;

  @override
  Widget build(BuildContext context) {
    return Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Card(
          child: Container(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(vertical: ConstScreen.setSizeHeight(15)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // TODO: Image Product
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ConstScreen.setSizeWidth(20)),
                      child: CachedNetworkImage(
                        imageUrl: productImage,
                        fit: BoxFit.fill,
                        height: ConstScreen.setSizeHeight(400),
                        width: ConstScreen.setSizeWidth(280),
                        placeholder: (context, url) => Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  //TODO: Detail product
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TitleWidget(
                          title: 'Tên: ',
                          content: productName,
                        ),
                        TitleWidget(
                          title: 'Số lượng: ',
                          content: quantity,
                        ),
                        TitleWidget(
                          title: 'Giá: ',
                          content: '${Util.intToMoneyType(productPrice)} VND',
                        ),
                        TitleWidget(
                          title: 'Giá khuyến mại: ',
                          content:
                              '${Util.intToMoneyType(productSalePrice)} VND',
                        ),
                        TitleWidget(
                          title: 'Hãng sản xuất: ',
                          content: category,
                        ),
                        TitleWidget(
                          title: 'Ngày tạo: ',
                          content: createAt,
                        ),
                        TitleWidget(
                          title: 'Màn hình: ',
                          content: (productSizeList != null)
                              ? '$productSizeList'
                              : 'None',
                        ),
                        Row(
                          children: <Widget>[
                            AutoSizeText(
                              '   Màu: ',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              minFontSize: 10,
                              style: kBoldTextStyle.copyWith(
                                  fontSize: FontSize.s30,
                                  color: kColorBlack.withOpacity(0.5)),
                            ),
                            (productColorList != null)
                                ? Row(
                                    children: productColorList.map((color) {
                                      return BoxInfo(
                                        color: Color(color),
                                        size: 25,
                                      );
                                    }).toList(),
                                  )
                                : AutoSizeText(
                                    '       None',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    minFontSize: 10,
                                    style: kBoldTextStyle.copyWith(
                                        fontSize: FontSize.s30,
                                        color: kColorBlack),
                                  ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        actions: <Widget>[
          IconSlideAction(
            caption: 'Comment',
            color: Colors.blueAccent,
            icon: Icons.insert_comment,
            onTap: () {
              onComment();
            },
          ),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Edit',
            color: Colors.black45,
            icon: Icons.edit,
            onTap: () {
              onEdit();
            },
          ),
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              onClose();
            },
          ),
        ]);
  }
}
