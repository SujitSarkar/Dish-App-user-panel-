import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/model/user_model.dart';

class PublicProvider extends ChangeNotifier{

  UserModel _userModel = UserModel();
  List<UserModel> _userList = [];
  bool _internetConnected=true;

  get userModel=> _userModel;
  get userList=> _userList;
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
        .where('id', isEqualTo: id).get();
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
      await FirebaseFirestore.instance.collection('Users').doc(pProvider.userModel.phone).set({
      'id':pProvider.userModel.phone,
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
      String id = await getPrefID();
      await FirebaseFirestore.instance.collection('Users').where('id', isEqualTo: id).get().then((snapshot){
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
}