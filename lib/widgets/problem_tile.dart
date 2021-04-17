import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:user_app/providers/public_provider.dart';
import 'package:user_app/public_variables/colors.dart';
import 'package:user_app/public_variables/design.dart';

// ignore: must_be_immutable
class ProblemTile extends StatelessWidget {
  int index;
  ProblemTile({this.index});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicProvider pProvider = Provider.of<PublicProvider>(context);
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
        leading: Icon(Icons.error_outline_outlined,
          color: Theme.of(context).primaryColor,
          size: size.width*.12,),

        title:
        ExpandableText(
          pProvider.problemList[index].problem,
          expandText: '>>',
          collapseText: '<<',
          maxLines: 3,
          linkColor: Theme.of(context).primaryColor,
          textAlign: TextAlign.justify,
          style: Design.subTitleStyle(size).copyWith(color: CustomColors.textColor,fontWeight: FontWeight.w500),
        ),

        subtitle: Text(DateFormat("dd-MMM-yyyy").format(DateTime.fromMillisecondsSinceEpoch(int.parse(pProvider.problemList[index].timeStamp))).toString(),
          style: Design.subTitleStyle(size).copyWith(color: Colors.grey[700]),
        ),
      ),
    );
  }
}