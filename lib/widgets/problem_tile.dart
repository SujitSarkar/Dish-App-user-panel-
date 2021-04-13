import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:user_app/public_variables/colors.dart';
import 'package:user_app/public_variables/design.dart';

// ignore: must_be_immutable
class ProblemTile extends StatelessWidget {
  int index;
  ProblemTile({this.index});

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
        leading: Icon(Icons.error_outline_outlined,
          color: Theme.of(context).primaryColor,
          size: size.width*.12,),

        title:
        ExpandableText(
          'গত তিন দিন ধরে আমাদের বাড়িতে কোন চ্যানেল দেখা যাচ্ছে না। '
              'গত তিন দিন ধরে আমাদের বাড়িতে কোন চ্যানেল দেখা যাচ্ছে না। '
              'গত তিন দিন ধরে আমাদের বাড়িতে কোন চ্যানেল দেখা যাচ্ছে না।',
          expandText: '>>',
          collapseText: '<<',
          maxLines: 3,
          linkColor: Theme.of(context).primaryColor,
          textAlign: TextAlign.justify,
          style: Design.subTitleStyle(size).copyWith(color: CustomColors.textColor,fontWeight: FontWeight.w500),
        ),

        subtitle: Text('10-Jan-2021',
          style: Design.subTitleStyle(size).copyWith(color: Colors.grey[700]),
        ),
      ),
    );
  }
}