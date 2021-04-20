import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/providers/public_provider.dart';
import 'package:user_app/public_variables/colors.dart';
import 'package:user_app/sub_pages/approved_bill_page.dart';
import 'package:user_app/sub_pages/pending_bill_page.dart';
import 'package:user_app/widgets/no_internet.dart';
import 'package:user_app/widgets/notifications.dart';

class BillingList extends StatefulWidget {
  @override
  _BillingListState createState() => _BillingListState();
}

class _BillingListState extends State<BillingList>
    with SingleTickerProviderStateMixin {

  TabController _controller;
  int _counter=0;

  _customInit(PublicProvider pProvider)async{
    setState(()=>_counter++);
    showLoadingDialog('অপেক্ষা করুন...');
    await pProvider.checkConnectivity();
    await pProvider.getBillingInfo().then((value){
      if(value==true){
        closeLoadingDialog();
      }else{
        closeLoadingDialog();
        showErrorMgs('');
      }
    },onError: (error){
      closeLoadingDialog();
      showErrorMgs(error.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final PublicProvider pProvider = Provider.of<PublicProvider>(context);
    if(_counter==0) _customInit(pProvider);
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        title: Text('বিলের তথ্য'),
        bottom: new TabBar(controller: _controller, tabs: [
          Tab(text: "বিচারাধীন"),
          Tab(text: "অনুমোদিত"),
        ]),
      ),
      body:pProvider.internetConnected==true? TabBarView(
        controller: _controller,
        children: <Widget>[
          PendingBill(),
          ApprovedBill(),
        ],
      ):NoInternet(),
    );
  }
}
