import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user_app/model/billing_info_model.dart';
import 'package:user_app/public_variables/colors.dart';
import 'package:user_app/public_variables/design.dart';

// ignore: must_be_immutable
class BillingInfoTile extends StatelessWidget {
  int index;
  List<BillingInfoModel> billingInfoList = [];
  BillingInfoTile({this.index,this.billingInfoList});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      //height: size.width*.25,
      margin: EdgeInsets.only(left: 10,right: 10,top: 15),
      decoration: BoxDecoration(borderRadius: Design.borderRadius,
          gradient: CustomColors.whiteGradientColor,
          boxShadow: [Design.cardShadow]
      ),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 5,right: 8,top: 0,bottom: 0),
        leading: Image.asset('assets/icon/taka1.png',height: size.width*.15,width: size.width*.15),
        title: Text(billingInfoList[index].monthYear,maxLines: 1,
            style: Design.titleStyle(size).copyWith(color: CustomColors.textColor)),
        subtitle: RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(
            //text: 'Hello ',
            style: Design.subTitleStyle(size),
            children: <TextSpan>[
              TextSpan(text: 'Amount: ', style: TextStyle(fontWeight: FontWeight.bold,color: CustomColors.liteGrey)),
              TextSpan(text: '${billingInfoList[index].amount} Tk\n', style: TextStyle(color: CustomColors.liteGrey)),
              TextSpan(text: billingInfoList[index].billType, style: TextStyle(color: CustomColors.liteGrey)),
            ],
          ),
        ),
      ),
    );
  }
}