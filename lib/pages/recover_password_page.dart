import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/pages/home_page.dart';
import 'package:user_app/providers/public_provider.dart';
import 'package:user_app/public_variables/colors.dart';
import 'package:user_app/public_variables/design.dart';
import 'package:user_app/widgets/buttons.dart';
import 'package:user_app/widgets/no_internet.dart';
import 'package:user_app/widgets/notifications.dart';
import 'package:user_app/widgets/routing_animation.dart';

class RecoverPassword extends StatefulWidget {
  @override
  _RecoverPasswordState createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPassword> {
  bool _isObscure = false, _otpVerified=false;
  String _phone='',_password='',_confirmPassword='',_verificationCode='';
  TextEditingController _otpController = TextEditingController();
  int _counter=0;

  _customInit(PublicProvider pProvider)async{
    await pProvider.checkConnectivity().then((value)=>setState(()=>_counter++));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicProvider pProvider = Provider.of<PublicProvider>(context);
    if(_counter==0)_customInit(pProvider);

    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: AppBar(
        title: Text('পাসওয়ার্ড পরিবর্তন করুন'),
        elevation: 0,
        centerTitle: true,
      ),
      body: pProvider.internetConnected==true? _bodyUI(size,pProvider):NoInternet(),
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
              _textField('+88 সহ মোবাইল নাম্বার', 'assets/field-icon/icon_phone.png', size),
              _otpVerified==true? _textField('পাসওয়ার্ড', "assets/field-icon/icon_password.png", size):Container(),
              _otpVerified==true? _textField('কনফার্ম পাসওয়ার্ড', "assets/field-icon/icon_password.png", size):Container(),
              SizedBox(height: 12),
              _otpVerified==false?GestureDetector(
                onTap: ()=>_formValidation(pProvider,'নিশ্চিত করুন'),
                child: shadowButton(size,'নিশ্চিত করুন'),
              ):Container(),

              _otpVerified==true?GestureDetector(
                onTap: ()=>_formValidation(pProvider,'পরিবর্তন করুন'),
                child: shadowButton(size,'পরিবর্তন করুন'),
              ):Container(),

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
            hint == '+88 সহ মোবাইল নাম্বার'
                ? TextInputType.phone
                : TextInputType.text,
            readOnly: hint=='+88 সহ মোবাইল নাম্বার' && _otpVerified==true
                ?true:false,
            obscureText:hint == 'পাসওয়ার্ড'? _isObscure ? true : false:false,
            style: Design.subTitleStyle(size).copyWith(
              color: CustomColors.textColor,
            ),
            onChanged: (val) =>
            hint == '+88 সহ মোবাইল নাম্বার' ? _phone = val
                :hint == 'পাসওয়ার্ড'? _password=val
                : _confirmPassword=val,
            decoration: Design.loginFormDecoration.copyWith(
              hintText: hint,
              labelText: hint,
              prefixIcon: Padding(
                padding: EdgeInsets.all(8.0),
                child: Image.asset(
                  prefixAsset,
                  width: 15,
                  height: 15,
                ),
              ),
              suffixIcon: hint == 'পাসওয়ার্ড' || hint =='কনফার্ম পাসওয়ার্ড'
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

  void _formValidation(PublicProvider pProvider, String identifier){
    if(identifier=='নিশ্চিত করুন'){
      if(_phone.isNotEmpty){
        if(_phone.length==14){
          if(_phone.contains('+88')){
            pProvider.checkConnectivity().then((value) async{
              if (pProvider.internetConnected == true){
                showLoadingDialog('অপেক্ষা করুন...');
                QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Users')
                    .where('id', isEqualTo: _phone).get();
                final List<QueryDocumentSnapshot> user = snapshot.docs;
                if(user.isNotEmpty){
                  _OTPVerification();
                }else{
                  closeLoadingDialog();
                  showErrorMgs('এই নাম্বারে কোন একাউন্ট নেই!');
                }
              }else showInfo('কোনও ইন্টারনেট সংযোগ নেই');
            },onError: (error){
              showErrorMgs(error.toString());
            });
          } else showInfo('+88 নিশ্চিত করা হয়নি');
        }else showInfo('+88 সহ ১১ সংখার মোবাইল নাম্বার নিশ্চিত করুন');
      }else showInfo('মোবাইল নাম্বার নিশ্চিত করুন');
    }else{
      if(_password.isNotEmpty && _confirmPassword.isNotEmpty){
        if(_password==_confirmPassword){
          pProvider.checkConnectivity().then((value){
            if(pProvider.internetConnected==true){
              showLoadingDialog('অপেক্ষা করুন...');
              pProvider.recoverUserPassword(_phone, _password).then((success)async{
                if(success==true){
                  SharedPreferences pref = await SharedPreferences.getInstance();
                  await pref.setString('id', _phone).then((value)async{
                    await pProvider.getUser().then((value){
                      if(value==true){
                        closeLoadingDialog();
                        showSuccessMgs('পাসওয়ার্ড পরিবর্তন সাফল হয়েছে!');
                        Navigator.pushAndRemoveUntil(context, AnimationPageRoute(navigateTo: HomePage()), (route) => false);
                      }else{
                        closeLoadingDialog();
                        showErrorMgs('পাসওয়ার্ড পরিবর্তন অসম্পন্ন হয়েছে!');
                        setState(()=>_otpVerified=false);
                      }
                    },onError: (error){
                      closeLoadingDialog();
                      showErrorMgs(error.toString());
                      setState(()=>_otpVerified=false);
                    });
                  },onError: (error){
                    closeLoadingDialog();
                    showErrorMgs(error.toString());
                    setState(()=>_otpVerified=false);
                  });
                }else{
                  closeLoadingDialog();
                  showErrorMgs('পাসওয়ার্ড পরিবর্তন অসম্পন্ন হয়েছে!');
                  setState(()=>_otpVerified=false);
                }
              });
            }else showInfo('কোনও ইন্টারনেট সংযোগ নেই!');
          },onError: (error){
            closeLoadingDialog();
            showErrorMgs(error.toString());
          });
        }else showInfo('পাসওয়ার্ড দুটির মধ্যে কোন মিল নেই');
      }else showInfo('পাসওয়ার্ড নিশ্চিত করুন');
    }
  }


  // ignore: non_constant_identifier_names
  void _OTPDialog(){
    showAnimatedDialog(
        context: context,
        barrierDismissible: false,
        animationType: DialogTransitionType.slideFromBottomFade,
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 500),
        builder: (context) {
          Size size=MediaQuery.of(context).size;
          return AlertDialog(
            scrollable: true,
            contentPadding: EdgeInsets.all(20),
            title: Text("ফোন যাচাইকরণ", style:TextStyle(fontSize: size.width*.04), textAlign: TextAlign.center),
            content: Container(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    child: Text(
                      "আমরা আপনার প্রদত্ত নম্বরটিতে ওটিপি যাচাইকরণ কোড প্রেরণ করেছি",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[700],fontSize: size.width*.034),
                    ),
                  ),
                  SizedBox(height: 25),
                  TextField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: size.width*.04),
                    decoration: InputDecoration(
                        labelText: "এখানে ওটিপি প্রবেশ করুন",
                        labelStyle: TextStyle(
                          fontSize: size.width*.033,
                        ),
                        fillColor: CustomColors.whiteColor,
                        prefixIcon: Icon(Icons.security)
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                onTap: ()async{
                  showLoadingDialog('অপেক্ষা করুন...');
                  try{
                    await FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(
                        verificationId: _verificationCode, smsCode: _otpController.text)).then((value)async{
                      if(value.user!=null){

                        setState(()=> _otpVerified=true);
                        closeLoadingDialog();
                        Navigator.pop(context);

                      }else{
                        closeLoadingDialog();
                        showErrorMgs('ভুল ওটিপি');
                      }
                    });
                  }catch(e){
                    closeLoadingDialog();
                    showErrorMgs(e.toString());
                  }
                },
                child: smallGradientButton(context, 'নিশ্চিত করুন'),
              ),
                  SizedBox(height: 15),

                  Text('দুই মিনিট পরে এই ওটিপি আর কাজ করবেনা',
                      textAlign: TextAlign.center,
                      style: Design.subTitleStyle(size).copyWith(color: CustomColors.liteGrey))
                ],
              ),
            ),
          );
        });
  }

  // ignore: non_constant_identifier_names
  Future<void> _OTPVerification()async{
    FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.verifyPhoneNumber(
      phoneNumber: _phone,
      //Automatic verify....
      verificationCompleted: (PhoneAuthCredential credential) async{
        await _auth.signInWithCredential(credential).then((value) async{
          if(value.user!=null){
            setState(()=> _otpVerified=true);
            closeLoadingDialog();
            Navigator.pop(context);
          }else{
            closeLoadingDialog();
            showErrorMgs('আপনার কাজ টি অস্মপ্পন্ন হয়েছে! আবার চেষ্টা করুন');
            setState(()=>_otpVerified=false);
          }
        });
      },
      verificationFailed: (FirebaseAuthException e){
        if (e.code == 'invalid-phone-number') {
          closeLoadingDialog();
          showErrorMgs('ভুল মোবাইল নাম্বার');
          setState(()=>_otpVerified=false);
        }
      },
      codeSent: (String verificationId, int resendToken){
        _verificationCode = verificationId;
        closeLoadingDialog();
        _OTPDialog();
      },
      codeAutoRetrievalTimeout: (String verificationId){
        _verificationCode = verificationId;
        closeLoadingDialog();
        _OTPDialog();
      },
      timeout: Duration(seconds: 120),

    );
  }
}
