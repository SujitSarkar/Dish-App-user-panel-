import 'package:flutter/material.dart';
import 'package:user_app/public_variables/design.dart';
// ignore: must_be_immutable
class ContactCardTile extends StatelessWidget {
  String imageAsset,title,content;
  ContactCardTile(this.imageAsset,this.title,this.content);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.width*.32,
      margin: EdgeInsets.only(left: 10,right: 10,top: 20),
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
      decoration: BoxDecoration(
          borderRadius: Design.borderRadius,
          image: DecorationImage(
              image: AssetImage('assets/gradient_image.jpg'),
              fit: BoxFit.cover
          ),
          boxShadow: [Design.cardShadow]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Image section
          Container(
            alignment: Alignment.center,
            width: size.width*.24,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white,width: 5),
                borderRadius: Design.borderRadius,
                image: DecorationImage(
                    image: AssetImage(imageAsset),
                    fit: BoxFit.contain
                )
            ),
          ),
          Container(
            width: size.width*.63,
            //color: Colors.green,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(title,
                  maxLines: 1,
                  style: Design.titleStyle(size),),
                SizedBox(height: size.width*.02),

                Text(content,
                  maxLines: 4,
                  style: Design.subTitleStyle(size),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}