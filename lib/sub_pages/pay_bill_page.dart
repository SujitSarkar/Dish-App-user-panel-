import 'package:flutter/material.dart';
import 'package:user_app/public_variables/colors.dart';
import 'package:user_app/public_variables/design.dart';
import 'package:user_app/public_variables/variables.dart';
import 'package:user_app/widgets/app_bar.dart';
import 'package:user_app/widgets/buttons.dart';
import 'package:user_app/widgets/instruction_tile.dart';
import 'package:user_app/widgets/notifications.dart';

class PayBill extends StatefulWidget {
  @override
  _PayBillState createState() => _PayBillState();
}

class _PayBillState extends State<PayBill> {
  String _phoneNumber = '', _transId = '', _billType;
  DateTime _date;
  TextEditingController _dateController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _transIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: PublicAppBar(context, "বিল পরিশোধ করুন"),
      ),
      body: _bodyUI(),
    );
  }

  Widget _bodyUI() {
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
                    //SizedBox(height: size.width * .03),

                    _textField('ট্রানজেকশন আইডি', size),
                    SizedBox(height: size.width * .04),

                    InkWell(
                      onTap: ()=> _formValidation(),
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

  void _formValidation(){
    if(_dateController.text.isNotEmpty){
      if(_billType!=null){
        if (_phoneNumber.isNotEmpty && _transId.isNotEmpty) {
          if(_phoneNumber.length==11){

          }else
            showInfo(
                'মোবাইল নাম্বার অবশ্যই ১১ সংখ্যার হতে হবে');
        } else
          showInfo(
              'মোবাইল নাম্বার এবং ট্রানজেকশন আইডি নিশ্চিত করুন');
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
                : _transIdController,
        onChanged: (val) =>
        hint == 'মোবাইল নাম্বার'
            ? _phoneNumber = _phoneController.text
            : _transId = _transIdController.text,
        keyboardType: hint == 'মোবাইল নাম্বার'
            ? TextInputType.number
            : TextInputType.text,
        decoration: Design.formDecoration(size).copyWith(labelText: hint),
      );
}
