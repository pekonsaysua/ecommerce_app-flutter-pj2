import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ecommerce/src/helpers/colors_constant.dart';
import 'package:ecommerce/src/helpers/utils.dart';
import 'package:ecommerce/src/widgets/card_user_info.dart';

class AdminUserListView extends StatefulWidget {
  @override
  _AdminUserListViewState createState() => _AdminUserListViewState();
}

class _AdminUserListViewState extends State<AdminUserListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('Users')
            .orderBy('create_at')
            .where('type', isEqualTo: 'admin')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            int index = 0;
            return ListView(
              children: snapshot.data.documents
                  .map((DocumentSnapshot document) {
                    index++;
                    return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      child: UserInfoCard(
                          id: index.toString(),
                          username: document['username'],
                          fullname: document['fullname'],
                          phone: document['phone'],
                          isAdmin: true,
                          createAt: Util.convertDateToFullString(
                              document['create_at'])),
                    );
                  })
                  .toList()
                  .reversed
                  .toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
