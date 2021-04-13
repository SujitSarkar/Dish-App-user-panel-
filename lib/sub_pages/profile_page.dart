import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_app/public_variables/colors.dart';
import 'package:user_app/public_variables/design.dart';
import 'package:user_app/widgets/buttons.dart';
import 'package:user_app/widgets/notifications.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File _image;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.width*.6),
        child: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle:true,
          elevation: 0,
          actions: [
            IconButton(
                icon: Icon(Icons.camera_alt,color: Colors.white,),
                splashRadius: size.width*.07,
                iconSize: size.width*.06,
                onPressed: ()=> _getImageFromGallery(),
            )
          ],
          title: Text('প্রোফাইল'),
          flexibleSpace: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              gradient: CustomColors.gradientColor
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: size.width*.3,
                  width: size.width*.3,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.all(Radius.circular(size.width*.7)),
                    image: DecorationImage(
                      image: _image==null? AssetImage('assets/account.png'):FileImage(_image),
                      fit: BoxFit.cover
                    ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black45,
                            blurRadius: 3,
                        )
                      ]
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('আপনার নাম এখানে',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: Design.titleStyle(size),),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),

      ///Body...
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context,index)=> AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 600),
            child: SlideAnimation(
              verticalOffset: 400,
              child: FadeInAnimation(
                child: CardBuilder(index: index),
              ),
            )
        ),
        ),
      ),
    );
  }

  Future<void> _getImageFromGallery()async{
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery,maxWidth: 300,maxHeight: 300);
    if(pickedFile!=null){
      setState(()=> _image = File(pickedFile.path));
    }else {
      showInfo('কোন ছবি নির্বাচন করা হয়নি');
    }
  }
  
}

// ignore: must_be_immutable
class CardBuilder extends StatelessWidget {
  int index;
  CardBuilder({this.index});

  String newAddress='';

  void _showUpdateAddressDialog(BuildContext context, Size size){
    showAnimatedDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            scrollable: true,
            title: Text('আপনার ঠিকানা পরিবর্তন করুন',
              textAlign: TextAlign.center,style: TextStyle(
                  color: Colors.grey[800],
                  fontSize:  size.width*.05
              ),),
            content: Column(
              children: [
                TextField(
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  onChanged: (val)=>newAddress=val,
                  maxLines: 5,
                  decoration: Design.formDecoration(size).copyWith(
                      labelText: 'নতুন ঠিকানা লিখুন'),
                ),
                SizedBox(height: size.width*.04),

                InkWell(
                  onTap: (){
                    if(newAddress.isNotEmpty){

                    }else showInfo('নতুন ঠিকানা লিখুন');
                  },
                  child: smallGradientButton(context, 'পরিবর্তন করুন'),
                  borderRadius: Design.buttonRadius,
                  splashColor: Theme.of(context).primaryColor,
                )
              ],
            ),

            actions: [
              IconButton(
                  icon: Icon(Icons.arrow_circle_down_outlined,color: CustomColors.deepGrey,size: size.width*.07),
                  splashRadius: size.width*.07,
                  onPressed: ()=>Navigator.pop(context)),
            ],
          );
        },
      animationType: DialogTransitionType.slideFromBottomFade,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 500),
    );
  }

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
                image: AssetImage(index==0?'assets/icon/phone.png':'assets/icon/address.png'),
                fit: BoxFit.contain
              )
            ),
          ),
          Container(
            width: size.width*.53,
            //color: Colors.green,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(index==0?'মোবাইল নাম্বার':'বড়ির ঠিকানা',
                  maxLines: 1,
                  style: Design.titleStyle(size),),
                SizedBox(height: size.width*.02),

                Text(index==0?'+8801830200087':'House-16(A3), Sonargaon Janapath Road, Sector-12, Uttara, Dhaka',
                  maxLines: 4,
                  style: Design.subTitleStyle(size),
                )
              ],
            ),
          ),
          Container(
            width: size.width*.1,
            decoration: BoxDecoration(
                //color: Colors.yellow,
              borderRadius: Design.borderRadius
            ),
            child: index==1? InkWell(
              child: Icon(Icons.edit_rounded,color: CustomColors.whiteColor),
              borderRadius: Design.borderRadius,
              splashColor: CustomColors.whiteColor,
              radius: 30,
              onTap: ()=>_showUpdateAddressDialog(context, size),
            ):Container(),
          )
        ],
      ),
    );
  }
}

