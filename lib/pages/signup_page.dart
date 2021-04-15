import 'package:provider/provider.dart';
import 'package:user_app/providers/public_provider.dart';
import 'package:user_app/public_variables/colors.dart';
import 'package:user_app/public_variables/design.dart';
import 'package:user_app/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:user_app/widgets/notifications.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isObscure = true;
  int _count=0;

  void _customInit(PublicProvider pProvider){
    pProvider.userModel.phone='';
    pProvider.userModel.password='';
    pProvider.userModel.nID='';
    pProvider.userModel.fatherName='';
    pProvider.userModel.address='';
    setState(()=>_count++);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicProvider pProvider = Provider.of<PublicProvider>(context);
    if(_count==0) _customInit(pProvider);
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: AppBar(
        title: Text('সাইন আপ'),
        elevation: 0,
        centerTitle: true,
      ),
      body: _bodyUI(size,pProvider),
    );
  }

  Widget _bodyUI(Size size,PublicProvider pProvider) => Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              color: CustomColors.appThemeColor,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: 15, right: 15, top: size.width * .08),
                    child: Hero(
                      tag: 'hero-login',
                      child: Image.asset(
                        'assets/g_banner.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                  color: CustomColors.greyWhite,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(50.0),
                    topRight: const Radius.circular(50.0),
                  )),
              child: buildBody(size, pProvider),
            ),
          ),
        ],
      );

  Widget buildBody(Size size,PublicProvider pProvider) =>
            Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(height: 0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(height: 30),
                    _textField('মোবাইল নাম্বার',
                        'assets/field-icon/icon_phone.png', size,pProvider),
                    _textField('পাসওয়ার্ড',
                        "assets/field-icon/icon_password.png", size,pProvider),
                    _textField('এন আইডি নাম্বার',
                        "assets/field-icon/icon_pad.png", size,pProvider),
                    _textField(
                        'বাবার নাম', "assets/field-icon/icon_user.png", size,pProvider),
                    _textField('বাড়ির ঠিকানা',
                        "assets/field-icon/icon_address.png", size,pProvider),
                    SizedBox(height: 12),

                    GestureDetector(
                      onTap: ()=>_formValidation(pProvider),
                      child: shadowButton(size, 'সাইন আপ'),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'আগে থেকেই একাউন্ট আছে?' + ' \n',
                                style: Design.subTitleStyle(size).copyWith(
                                  color: CustomColors.textColor,
                                )),
                            TextSpan(
                                text: 'লগ ইন',
                                style: Design.titleStyle(size).copyWith(
                                  decoration: TextDecoration.underline,
                                  color: CustomColors.textColor,
                                )),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {},
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Powered by ',
                        style: Design.subTitleStyle(size).copyWith(
                          color: CustomColors.liteGrey2,
                        )),
                    TextSpan(
                        text: 'Glamworld IT',
                        style: Design.subTitleStyle(size).copyWith(
                          decoration: TextDecoration.underline,
                          color: CustomColors.textColor,
                        )),
                  ]),
                ),
              ),
            ),
          ],
        );

  Widget _textField(String hint, String prefixAsset, Size size,PublicProvider pProvider) =>
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: TextField(
            keyboardType:
            hint == 'মোবাইল নাম্বার' || hint == 'এন আইডি নাম্বার'
                ? TextInputType.phone
                : TextInputType.text,
            obscureText:hint == 'পাসওয়ার্ড'? _isObscure ? true : false:false,
            style: Design.subTitleStyle(size).copyWith(
              color: CustomColors.textColor,
            ),
            onChanged: (val) => hint == 'মোবাইল নাম্বার'
                ? pProvider.userModel.phone = val
                : hint == 'পাসওয়ার্ড'
                ? pProvider.userModel.password = val
                : hint == 'এন আইডি নাম্বার'
                ? pProvider.userModel.nID = val
                : hint == 'বাবার নাম'
                ? pProvider.userModel.fatherName = val
                : pProvider.userModel.address = val,
            decoration: Design.loginFormDecoration.copyWith(
              hintText: hint,
              prefixIcon: Padding(
                padding: EdgeInsets.all(8.0),
                child: Image.asset(
                  prefixAsset,
                  width: 15,
                  height: 15,
                ),
              ),
              suffixIcon: hint == 'পাসওয়ার্ড'
                  ? GestureDetector(
                  onTap: () => setState(() => _isObscure = !_isObscure),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image.asset(
                      _isObscure
                          ? "assets/field-icon/icon_eye_close.png"
                          : "assets/field-icon/icon_eye_open.png",
                      width: 15,
                      height: 15,
                    ),
                  ))
                  : null,
            )),
      );

  void _formValidation(PublicProvider pProvider){
    if(pProvider.userModel.phone.isNotEmpty &&
    pProvider.userModel.password.isNotEmpty &&
    pProvider.userModel.nID.isNotEmpty &&
    pProvider.userModel.fatherName.isNotEmpty &&
    pProvider.userModel.address.isNotEmpty){
      if(pProvider.userModel.phone.length==11){

      }else showInfo('মোবাইল নাম্বার ১১ সংখ্যার হতে হবে');

    }else showInfo('ফর্ম পুরন করুন');
  }
}
