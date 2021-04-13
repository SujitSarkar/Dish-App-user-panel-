import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/pages/recover_password_page.dart';
import 'package:user_app/pages/signup_page.dart';
import 'package:user_app/providers/public_provider.dart';
import 'package:user_app/public_variables/colors.dart';
import 'package:user_app/public_variables/design.dart';
import 'package:user_app/widgets/buttons.dart';
import 'package:user_app/widgets/notifications.dart';
import 'package:user_app/widgets/routing_animation.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  String _phone='',_password='';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicProvider pProvider = Provider.of<PublicProvider>(context);
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: AppBar(
        title: Text('লগ ইন'),
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
                        left: 15,right: 15, top: size.width*.08),
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
              height: MediaQuery.of(context).size.height * 0.65,
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                  color: CustomColors.greyWhite,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(50.0),
                    topRight: const Radius.circular(50.0),
                  )),
              child: buildBody(size,pProvider),
            ),
          ),
        ],
      );

  Widget buildBody(Size size,PublicProvider pProvider)=> Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          height: 0,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 30),
                _textField('মোবাইল নাম্বার', 'assets/field-icon/icon_phone.png', size),
                _textField('পাসয়ার্ড', "assets/field-icon/icon_password.png", size),
                SizedBox(height: 12),
                GestureDetector(
                  onTap: ()=>_formValidation(pProvider),
                  child: shadowButton(size, 'লগ ইন'),
                ),
                GestureDetector(
                  onTap: ()=>Navigator.push(context, AnimationPageRoute(navigateTo: RecoverPassword())),
                  child: Padding(
                    padding:EdgeInsets.only(top: 25, left: 10, right: 10),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'পাসয়ার্ড পরিবর্তন করুন',
                            style: Design.titleStyle(size).copyWith(
                              decoration: TextDecoration.underline,
                              color: CustomColors.textColor,
                            )),
                      ]),
                    ),
                  ),
                ),
                GestureDetector(
                    onTap:()=>Navigator.push(context, AnimationPageRoute(navigateTo: SignUpPage())),
                  child: Padding(
                    padding:EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'আপনার কোন একাউন্ট নেই?' + ' \n',
                            style: Design.subTitleStyle(size).copyWith(
                              color: CustomColors.textColor,
                            )),
                        TextSpan(
                            text: 'একাউন্ট খুলুন',
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
            onTap: (){},
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


  Widget _textField(String hint, String prefixAsset, Size size) =>
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: TextField(
            keyboardType:
            hint == 'মোবাইল নাম্বার'
                ? TextInputType.number
                : TextInputType.text,
            obscureText:hint == 'পাসয়ার্ড'? _isObscure ? true : false:false,
            style: Design.subTitleStyle(size).copyWith(
              color: CustomColors.textColor,
            ),
            onChanged: (val) => hint == 'মোবাইল নাম্বার'
                ? _phone = val
                : _password = val,
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
              suffixIcon: hint == 'পাসয়ার্ড'
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
    if(_phone.isNotEmpty && _password.isNotEmpty){
      if(_phone.length==11){

      }else showInfo('মোবাইল নাম্বার ১১ সংখ্যার হতে হবে');
    }else showInfo('মোবাইল এবং পাসওয়ার্ড প্রদান করুন');
  }
}
