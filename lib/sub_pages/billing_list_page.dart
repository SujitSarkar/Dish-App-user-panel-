import 'package:flutter/material.dart';
import 'package:user_app/public_variables/colors.dart';
import 'package:user_app/sub_pages/approved_bill_page.dart';
import 'package:user_app/sub_pages/pending_bill_page.dart';
import 'package:user_app/widgets/notifications.dart';

class BillingList extends StatefulWidget {
  @override
  _BillingListState createState() => _BillingListState();
}

class _BillingListState extends State<BillingList>
    with SingleTickerProviderStateMixin {

  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 2, vsync: this);

    showLoadingDialog('Getting ready...');
    Future.delayed(Duration(seconds: 2)).then((value) {
      closeLoadingDialog();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        title: Text('বিলের তথ্য'),
        bottom: new TabBar(controller: _controller, tabs: [
          Tab(text: "অনুমোদিত"),
          Tab(text: "বিচারাধীন"),
        ]),
      ),
      body:TabBarView(
        controller: _controller,
        children: <Widget>[
          ApprovedBill(),
          PendingBill(),
        ],
      ),
    );
  }
}
