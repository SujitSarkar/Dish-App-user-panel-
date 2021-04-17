import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:user_app/providers/public_provider.dart';
import 'package:user_app/public_variables/colors.dart';
import 'package:user_app/public_variables/design.dart';
import 'package:user_app/widgets/app_bar.dart';
import 'package:user_app/widgets/buttons.dart';
import 'package:user_app/widgets/no_internet.dart';
import 'package:user_app/widgets/notifications.dart';
import 'package:user_app/widgets/problem_tile.dart';

class ProblemPage extends StatefulWidget {
  @override
  _ProblemPageState createState() => _ProblemPageState();
}

class _ProblemPageState extends State<ProblemPage> {
  String problem='';
  int _counter=0;

  _customInit(PublicProvider pProvider)async{
    pProvider.checkConnectivity();
    pProvider.getAllProblems();
    setState(()=>_counter++);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicProvider pProvider = Provider.of<PublicProvider>(context);
    if(_counter==0) _customInit(pProvider);

    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: PublicAppBar(context, "আপনার সমস্যা জানান"),
      ),
      body: pProvider.internetConnected==true? _bodyUI(pProvider):NoInternet(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        splashColor: CustomColors.whiteColor,
        child: IconButton(
          onPressed: ()=>_showSubmitProblemDialog(context, size,pProvider),
          icon: Icon(Icons.add,color: CustomColors.whiteColor,size: size.width*.08,),
        ),
      ),
    );
  }

  Widget _bodyUI(PublicProvider pProvider)=>AnimationLimiter(
    child: RefreshIndicator(
      backgroundColor: CustomColors.whiteColor,
      onRefresh: () async {await pProvider.getAllProblems();},
      child: ListView.builder(
        itemCount: pProvider.problemList.length,
        itemBuilder: (context, index) =>
            AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 400),
                child: SlideAnimation(
                    verticalOffset: 400,
                    child: FadeInAnimation(
                      child: ProblemTile(index: index),
                    ))),
      ),
    ),
  );

  void _showSubmitProblemDialog(BuildContext context, Size size,PublicProvider pProvider){
    showAnimatedDialog(
      context: context,
      animationType: DialogTransitionType.slideFromBottomFade,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 500),
      builder: (context){
        return AlertDialog(
          scrollable: true,
          title: Text('আপনার সমস্যা লিখুন',
            textAlign: TextAlign.center,style: TextStyle(
                color: Colors.grey[800],
                fontSize:  size.width*.05
            ),),
          content: Column(
            children: [
              TextField(
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                onChanged: (val)=>problem=val,
                maxLines:5,
                decoration: Design.formDecoration(size).copyWith(
                    labelText: 'নতুন সমস্যা লিখুন'),
              ),
              SizedBox(height: size.width*.04),

              InkWell(
                onTap: ()async{
                  if(problem.isNotEmpty){
                    await pProvider.checkConnectivity().then((value){
                      if(pProvider.internetConnected==true){
                        showLoadingDialog('অপেক্ষা করুন...');
                        pProvider.submitProblem(problem).then((success)async{
                          if(success==true){
                            await pProvider.getAllProblems();
                            closeLoadingDialog();
                            showSuccessMgs('সমস্যা জমা দেওয়া সাফল হয়েছে!');
                            Navigator.pop(context);
                          }else{
                            closeLoadingDialog();
                            showErrorMgs('সমস্যা জমা দেওয়া ব্যর্থ হয়েছে!');
                          }
                        },onError: (error){
                          closeLoadingDialog();
                          showErrorMgs(error.toString());
                        });
                      }else{
                        showInfo('কোনও ইন্টারনেট সংযোগ নেই!');
                        Navigator.pop(context);
                      }
                    });
                  }else showInfo('নতুন সমস্যা লিখুন');
                },
                child: smallGradientButton(context, 'জমা দিন'),
                borderRadius: Design.buttonRadius,
                splashColor: Theme.of(context).primaryColor,
              )
            ],
          ),

          actions: [
            IconButton(
                icon: Icon(Icons.arrow_circle_down_outlined,color: CustomColors.deepGrey,size: size.width*.07),
                splashRadius: size.width*.07,
                onPressed: ()=>Navigator.pop(context)),
          ],
        );
      },

    );
  }
}
