import 'package:flutter/material.dart';
import 'package:user_app/public_variables/colors.dart';
import 'package:user_app/public_variables/variables.dart';
import 'package:user_app/widgets/app_bar.dart';
import 'package:user_app/widgets/contact_us_tile.dart';
import 'package:user_app/widgets/instruction_tile.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: PublicAppBar(context, "যোগাযোগ করুন"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///Instruction builder
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10, top: 10),
              child: InstructionTile(Variables.paymentInstruction),
            ),

            ContactCardTile('assets/icon/phone.png','গ্রাহক সেবা', Variables.customerCareNumber),
            ContactCardTile('assets/icon/address.png', 'অফিসের ঠিকানা', Variables.officeAddress),
          ],
        ),
      ),
    );
  }

}

