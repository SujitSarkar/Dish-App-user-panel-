import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';

class Variables {
  static final String appTitle = 'পারভেজ স্যাটেলাইট';
  static final String appLongTitle = 'পারভেজ ইউনাইটেড স্যাটেলাইট, চর-চারুয়া, দাউদকান্দি, কুমিল্লা';
  static final String paymentInstruction =
      'আপনার ডিস বিল টি পরিশোধ করতে প্রথমে ক্যালেন্ডার থেকে যে মাসের বিল দিতে '
      'চান সেই মাস টি চয়ন করুন। তারপর নিন্মে বর্নিত নাম্বারে আপনার \"বিকাশ\" অথবা \"রকেট\" থেকে সেন্ড-মানি করুন। '
      'সেন্ড-মানি সম্পন্ন হলে যেই নাম্বার থেকে বিল পরিশোধ করেছেন ঐ নাম্বার এবং ট্রানজেকশন আইডি '
      'প্রদান করে সম্পন্ন বাটনে প্রেস করুন।';
  static final String paymentNote =
      'আপনার বিল পরিশোধ সম্পন্ন হলে আমাদের কর্তৃপক্ষ দ্বারা '
      'তা যাচাই করা হবে। যাচাই করা সম্পন্ন হলে আপনার বিল পরিশোধ পম্পূর্ন হবে।';

  static final List<String> billType = ['ডিস বিল', 'ইন্টারনেট বিল'];

  static final List<String> homeMenuText = [
    "প্রোফাইল",
    "বিলের তথ্য",
    "বিল পরিশোধ করুন",
    "আপনার সমস্যা জানান",
    "আমাদের সার্ভিস সমূহ",
    "যোগাযোগের ঠিকানা",
    "লগ আউট",
  ];

  static final List<IconData> homeMenuIcon = [
    Icons.person_outline,
    Icons.payment_outlined,
    Icons.monetization_on_outlined,
    Icons.error_outline,
    Icons.work_outline,
    Icons.sms_outlined,
    Icons.logout,
  ];

  static final List<String> imgList = [
    'assets/slider-image/img1.jpg',
    'assets/slider-image/img2.png',
    'assets/slider-image/img3.jpg',
    'assets/slider-image/img4.jpg',
    'assets/slider-image/img5.jpg',
  ];
  static List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.asset(item, fit: BoxFit.cover, width: 500.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            'No. ${imgList.indexOf(item)} image',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();
}
