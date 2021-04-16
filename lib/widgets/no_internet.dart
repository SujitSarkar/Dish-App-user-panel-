import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/providers/public_provider.dart';
import 'package:user_app/public_variables/colors.dart';
import 'package:user_app/public_variables/design.dart';

class NoInternet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<PublicProvider>(builder: (context, pProvider, child){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: CustomColors.whiteColor,
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.wifi_exclamationmark,
              color: CustomColors.warningColor,
              size: size.width*.4,
            ),
            Text(
              'কোনও ইন্টারনেট সংযোগ নেই !',
              textAlign: TextAlign.center,
              style: Design.titleStyle(size).copyWith(color: CustomColors.textColor),
            ),
            Text(
              'আপনার ডিভাইসটি ওয়াইফাই বা সেলুলার ডেটার সাথে সংযুক্ত করুন',
              textAlign: TextAlign.center,
              style:  Design.subTitleStyle(size).copyWith(color: CustomColors.liteGrey),
            ),
            SizedBox(height: size.width*.05),

            TextButton(
                onPressed: ()=>pProvider.checkConnectivity(),
                child: Text(
                  'রিফ্রেশ করুন',
                  style: Design.subTitleStyle(size).copyWith(color: CustomColors.appThemeColor,fontWeight: FontWeight.bold),
                )
            )
          ],
        ),
      );
    }
    );
  }
}
