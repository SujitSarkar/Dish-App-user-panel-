import 'package:flutter/material.dart';
import 'package:user_app/model/user_model.dart';

class PublicProvider extends ChangeNotifier{

  UserModel _userModel = UserModel();

  get userModel=> _userModel;

  set userModel(UserModel val){
    val= UserModel();
    _userModel = val;
    notifyListeners();
  }
}