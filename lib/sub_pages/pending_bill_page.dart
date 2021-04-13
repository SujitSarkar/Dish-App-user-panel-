import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:user_app/public_variables/colors.dart';
import 'package:user_app/widgets/billing_info_tile.dart';

class PendingBill extends StatefulWidget {
  @override
  _PendingBillState createState() => _PendingBillState();
}

class _PendingBillState extends State<PendingBill> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      body: AnimationLimiter(
        child: RefreshIndicator(
          backgroundColor: CustomColors.whiteColor,
          onRefresh: () async {},
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) =>
                AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 400),
                    child: SlideAnimation(
                        horizontalOffset: 400,
                        child: FadeInAnimation(
                          child: BillingInfoTile(index: index),
                        ))),
          ),
        ),
      ),
    );
  }
}
