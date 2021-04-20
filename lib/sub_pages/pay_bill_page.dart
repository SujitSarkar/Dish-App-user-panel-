import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/providers/public_provider.dart';
import 'package:user_app/public_variables/colors.dart';
import 'package:user_app/public_variables/design.dart';
import 'package:user_app/public_variables/variables.dart';
import 'package:user_app/widgets/app_bar.dart';
import 'package:user_app/widgets/buttons.dart';
import 'package:user_app/widgets/instruction_tile.dart';
import 'package:user_app/widgets/no_internet.dart';
import 'package:user_app/widgets/notifications.dart';

class PayBill extends StatefulWidget {
  @override
  _PayBillState createState() => _PayBillState();
}

class _PayBillState extends State<PayBill> {
  String _billType;
  DateTime _date;
  TextEditingController _dateController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _transIdController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  int _counter=0;

  _customInit(PublicProvider pProvider)async{
    setState(()=>_counter++);
    showLoadingDialog('অপেক্ষা করুন...');
    pProvider.checkConnectivity();
    pProvider.getAllProblems().then((value)=>closeLoadingDialog());
  }

  @override
  Widget build(BuildContext context) {
    //final Size size = MediaQuery.of(context).size;
    final PublicProvider pProvider = Provider.of<PublicProvider>(context);
    if(_counter==0) _customInit(pProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: PublicAppBar(context, "বিল পরিশোধ করুন"),
      ),
      body: pProvider.internetConnected==true? _bodyUI(pProvider):NoInternet(),
    );
  }

  Widget _bodyUI(PublicProvider pProvider) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///Instruction builder
            InstructionTile(Variables.paymentInstruction),
            SizedBox(height: size.width * .04),

            ///Note builder
            Container(
              width: size.width,
              decoration: BoxDecoration(
                  borderRadius: Design.borderRadius,
                  gradient: CustomColors.whiteGradientColor,
                  boxShadow: [Design.cardShadow]),
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      //text: 'Hello ',
                      style: Design.warningSubTitleStyle(size)
                          .copyWith(fontSize: size.width * .035),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'বিঃ দ্রঃ: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:Variables.paymentNote),
                      ],
                    ),
                  )),
            ),
            SizedBox(height: size.width * .04),

            ///Form Section
            Container(
              width: size.width,
              decoration: BoxDecoration(
                  borderRadius: Design.borderRadius,
                  gradient: CustomColors.whiteGradientColor,
                  boxShadow: [Design.cardShadow]),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ///Date picker
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                            alignment: Alignment.bottomLeft,
                            width: size.width * .1,
                            child: InkWell(
                              onTap: ()=> _pickDate(),
                              borderRadius: Design.buttonRadius,
                              splashColor: Theme.of(context).primaryColor,
                              child: Icon(Icons.calendar_today_outlined,
                                  color: Theme.of(context).primaryColor,
                                  size: size.width * .075),
                            ),
                        ),
                        Container(
                          width: size.width * .78,
                          child: _textField('তারিখ', size),
                        ),
                      ],
                    ),
                    SizedBox(height: size.width * .04),

                    DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: _billType,
                        isExpanded: true,
                        hint: Text("বিলের বিবরণ",style: TextStyle(
                            color: CustomColors.liteGrey,
                            fontSize: size.width*.04)),
                        items: Variables.billType.map((category){
                          return DropdownMenuItem(
                            child: Text(category,style: TextStyle(
                              color: CustomColors.textColor,
                              fontSize: size.width*.04,)),
                            value: category,
                          );
                        }).toList(),
                        onChanged: (newValue)=> setState(() => _billType = newValue),
                        dropdownColor: CustomColors.whiteColor,
                      ),
                    ),
                    Divider(height: 0,thickness: 1,color: CustomColors.liteGrey2),
                    SizedBox(height: size.width * .03),

                    _textField('মোবাইল নাম্বার', size),

                    _textField('ট্রানজেকশন আইডি', size),
                    _textField('বিলের পরিমান', size),
                    SizedBox(height: size.width * .04),

                    InkWell(
                      onTap: ()async{
                        await pProvider.checkConnectivity().then((value){
                          if(pProvider.internetConnected==true) _formValidation(pProvider);
                          else showErrorMgs('কোনও ইন্টারনেট সংযোগ নেই');
                        },onError: (error)=>showErrorMgs(error.toString()));
                      },
                      child: smallGradientButton(context, 'নিশ্চিত করুন'),
                      borderRadius: Design.buttonRadius,
                      splashColor: Theme.of(context).primaryColor,
                    ),
                    //SizedBox(height: size.width*.04),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _formValidation(PublicProvider pProvider){
    if(_dateController.text.isNotEmpty){
      if(_billType!=null){
        if (_phoneController.text.isNotEmpty && _transIdController.text.isNotEmpty && _amountController.text.isNotEmpty) {
          if(_phoneController.text.length==11){
            showLoadingDialog('অপেক্ষা করুন...');
            pProvider.submitBill(_date,_billType, _phoneController.text, _transIdController.text,_amountController.text).then((success){
              if(success==true){
                closeLoadingDialog();
                showSuccessMgs('বিল প্রদান সম্পন্ন হয়েছে');
                _phoneController.clear();
                _transIdController.clear();
                _amountController.clear();
              }else{
                closeLoadingDialog();
                showErrorMgs('বিল প্রদান অসম্পন্ন হয়েছে!');
              }
            },onError: (error){
              closeLoadingDialog();
              showErrorMgs(error.toString());
            });
          }else
            showInfo(
                'মোবাইল নাম্বার অবশ্যই ১১ সংখ্যার হতে হবে');
        } else
          showInfo(
              'মোবাইল নাম্বার, ট্রানজেকশন আইডি এবং বিলের পরিমান নিশ্চিত করুন');
      }else
        showInfo(
            'বিলের বিবরণ নিশ্চিত করুন');
    }else
      showInfo(
          'বিলের তারিখ নিশ্চিত করুন');
  }

  void _pickDate(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2010),
        lastDate: DateTime(2050),
    ).then((date)=>
      setState((){
        _date=date;
        _dateController.text='${_date.day}-${_date.month}-${_date.year}';
      }));
  }

  TextFormField _textField(String hint, Size size) => TextFormField(
    maxLength: hint == 'মোবাইল নাম্বার' ?11:null,
    readOnly: hint == 'তারিখ' ?true:false,
        onTap: ()=> hint=='তারিখ'?_pickDate():null,
        controller:
            hint == 'তারিখ' ? _dateController
                : hint == 'মোবাইল নাম্বার' ? _phoneController
                : hint == 'বিলের পরিমান' ? _amountController
                : _transIdController,
        keyboardType: hint == 'মোবাইল নাম্বার'
            ? TextInputType.phone
            : hint == 'বিলের পরিমান'
            ? TextInputType.number
            : TextInputType.text,
        decoration: Design.formDecoration(size).copyWith(labelText: hint),
      );
}
