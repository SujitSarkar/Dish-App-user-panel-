import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:marquee_flutter/marquee_flutter.dart';
import 'package:user_app/pages/login_page.dart';
import 'package:user_app/public_variables/colors.dart';
import 'package:user_app/public_variables/design.dart';
import 'package:user_app/public_variables/variables.dart';
import 'package:user_app/sub_pages/pay_bill_page.dart';
import 'package:user_app/sub_pages/billing_list_page.dart';
import 'package:user_app/sub_pages/contact_us_page.dart';
import 'package:user_app/sub_pages/problem_page.dart';
import 'package:user_app/sub_pages/profile_page.dart';
import 'package:user_app/sub_pages/our_services_page.dart';
import 'package:user_app/widgets/app_bar.dart';
import 'package:user_app/widgets/home_grid_tile.dart';
import 'package:user_app/widgets/routing_animation.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: PublicAppBar(context, Variables.appTitle)),
      body: _bodyUI(),
    );
  }

  Widget _bodyUI() {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        ///Image Slider
        Container(
          height: size.width*.5,
          width: size.width,
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            ),
            items: Variables.imageSliders,
          ),
        ),

        ///Marque Container
        Container(
          height: size.width * .1,
          alignment: Alignment.center,
          child: MarqueeWidget(
            text:
                "২৪ ঘন্টা সার্ভিস পেতে ০১৮২৩৪৮১২৩ নাম্বারে কল করুন । ${Variables.appTitle} এর সাথে থাকার জন্য ধন্যবাদ ।",
            textStyle: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: size.width * .05),
            scrollAxis: Axis.horizontal,
          ),
        ),

        ///GridView
        Expanded(
          child: AnimationLimiter(
            child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: Variables.homeMenuText.length,
              itemBuilder: (context, index) =>
                  AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 600),
                      child: SlideAnimation(
                        verticalOffset: 400,
                        child: FadeInAnimation(
                          child: InkWell(
                              borderRadius: Design.borderRadius,
                              splashColor: Theme.of(context).primaryColor,
                              onTap: () => index == 0
                                  ?Navigator.push(context, AnimationPageRoute(navigateTo: ProfilePage()))
                                  : index == 1
                                      ? Navigator.push(context, AnimationPageRoute(navigateTo: BillingList()))
                                      : index == 2
                                          ? Navigator.push(context, AnimationPageRoute(navigateTo: PayBill()))
                                          : index == 3
                                              ? Navigator.push(context, AnimationPageRoute(navigateTo: ProblemPage()))
                                              : index == 4
                                                  ? Navigator.push(context, AnimationPageRoute(navigateTo: OurServices()))
                                                  : index == 5
                                                      ? Navigator.push(context, AnimationPageRoute(navigateTo: ContactUs()))
                                                      : Navigator.push(context, AnimationPageRoute(navigateTo: LoginPage())),
                              child: HomeMenuTile(index: index)),
                        ),
                      )),
            ),
          ),
        ),
      ],
    );
  }


}
