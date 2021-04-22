import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/providers/public_provider.dart';
import 'package:user_app/public_variables/colors.dart';
import 'package:user_app/public_variables/design.dart';
import 'package:user_app/public_variables/variables.dart';
import 'package:user_app/widgets/app_bar.dart';
import 'package:user_app/widgets/instruction_tile.dart';

class OurServices extends StatefulWidget {
  @override
  _OurServicesState createState() => _OurServicesState();
}

class _OurServicesState extends State<OurServices> {
  @override
  Widget build(BuildContext context) {
    final PublicProvider pProvider = Provider.of<PublicProvider>(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: PublicAppBar(context, "আমাদের সার্ভিস সমূহ"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: InstructionTile(pProvider.services??''),
            ),
            SizedBox(height: size.width * .04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _serviceImage('assets/icon/dish.png', size),
                  _serviceImage('assets/icon/internet.png', size),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _serviceName('Cable Dish', size),
                  _serviceName('Internet Connection', size),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _serviceImage(String imageAsset, Size size) => Container(
        width: size.width * .45,
        height: size.width * .45,
        decoration: BoxDecoration(
          borderRadius: Design.borderRadius,
          gradient: CustomColors.whiteGradientColor,
          image: DecorationImage(
              image: AssetImage(imageAsset), fit: BoxFit.contain),
        ),
      );

  Widget _serviceName(String name, Size size) => Container(
        width: size.width * .45,
        height: size.width * .45,
        child: Text(name,
            textAlign: TextAlign.center,
            style: Design.titleStyle(size)
                .copyWith(color: CustomColors.textColor)),
      );
}
