import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/model/problem_model.dart';
import 'package:user_app/model/user_model.dart';

class PublicProvider extends ChangeNotifier{

  UserModel _userModel = UserModel();
  bool _internetConnected=true;
  List<UserModel> _userList = [];
  List<ProblemModel> _problemList = [];


  get userModel=> _userModel;
  get userList=> _userList;
  get problemList=> _problemList;
  get internetConnected=> _internetConnected;

  set userModel(UserModel val){
    val= UserModel();
    _userModel = val;
    notifyListeners();
  }

  Future<void> checkConnectivity() async {
    var result = await (Connectivity().checkConnectivity());

    if (result == ConnectivityResult.none) {
      _internetConnected = false;
      notifyListeners();
    } else if (result == ConnectivityResult.mobile) {
      _internetConnected = true;
      notifyListeners();
    } else if (result == ConnectivityResult.wifi) {
      _internetConnected = true;
      notifyListeners();
    }
  }

  Future<String> getPrefID()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.get('id');
  }

  Future<bool> isUserRegistered(String id)async{
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Users')
        .where('id', isEqualTo: '+88$id').get();
    final List<QueryDocumentSnapshot> user = snapshot.docs;
    if(user.isEmpty){
      return false;
    }else{
      return true;
    }
  }

  Future<bool> registerUser(PublicProvider pProvider)async{
    try{
      int timeStamp = DateTime.now().millisecondsSinceEpoch;
      await FirebaseFirestore.instance.collection('Users').doc('+88${pProvider.userModel.phone}').set({
      'id':'+88${pProvider.userModel.phone}',
      'phone':pProvider.userModel.phone,
        'name':pProvider.userModel.name,
      'password':pProvider.userModel.password,
      'nID':pProvider.userModel.nID,
      'fatherName':pProvider.userModel.fatherName,
      'address':pProvider.userModel.address,
      'timeStamp': timeStamp.toString(),
      'month': DateTime.now().month.toString(),
      'year': DateTime.now().year.toString(),
      'day': DateTime.now().day.toString(),
      });
      return Future.value(true);
    }catch(error){
      return Future.value(false);
    }
  }

  Future<bool> getUser()async{
    try{
      final String id = await getPrefID();
      await FirebaseFirestore.instance.collection('Users').where('id', isEqualTo: id).get().then((snapshot){
        _userList.clear();
        snapshot.docChanges.forEach((element) {
          UserModel userModel = UserModel(
              id: element.doc['id'],
              phone: element.doc['phone'],
              name: element.doc['name'],
              password: element.doc['password'],
              nID: element.doc['nID'],
              fatherName: element.doc['fatherName'],
              address: element.doc['address'],
              timeStamp: element.doc['timeStamp'],
              month: element.doc['month'],
              year: element.doc['year'],
              day: element.doc['day'],
          );
          _userList.add(userModel);
        });
      });
      notifyListeners();
      return Future.value(true);
    }catch(error){
      return Future.value(false);
    }
  }

  Future<bool> updateUser(Map<String, String> dataMap)async{
    try{
      final String id = await getPrefID();
      await FirebaseFirestore.instance.collection('Users').doc(id).update(dataMap);
      return Future.value(true);
    }catch(error){
      return Future.value(false);
    }
  }

  Future<bool> recoverUserPassword(String id, String password)async{
    try{
      await FirebaseFirestore.instance.collection('Users').doc(id).update({
        'password':password,
      });
      return Future.value(true);
    }catch(error){
      return Future.value(false);
    }
  }

  Future<bool> submitProblem(String problem)async{
    try{
      String id = await getPrefID();
      int timeStamp = DateTime.now().millisecondsSinceEpoch;
      if(userList.isEmpty) getUser();
      await FirebaseFirestore.instance.collection('UserProblems').doc('$id$timeStamp').set({
        'id':'$id$timeStamp',
        'name':userList[0].name,
        'phone': userList[0].id,
        'address':userList[0].address,
        'problem': problem,
        'timeStamp': timeStamp.toString(),
      });
      return Future.value(true);
    }catch(error){
      return Future.value(false);
    }
  }

  Future<bool> getAllProblems()async{
    try{
       String id = await getPrefID();
      await FirebaseFirestore.instance.collection('UserProblems').where('phone', isEqualTo: id).orderBy('timeStamp',descending: true).get().then((snapshot){
        _problemList.clear();
        snapshot.docChanges.forEach((element) {
          ProblemModel problemModel = ProblemModel(
            id: element.doc['id'],
            name: element.doc['name'],
            phone: element.doc['phone'],
            address: element.doc['address'],
            problem: element.doc['problem'],
            timeStamp: element.doc['timeStamp'],
          );
          _problemList.add(problemModel);
        });
      });
      notifyListeners();
      return Future.value(true);
    }catch(error){
      return Future.value(false);
    }
  }
}