
import 'package:buildittt/screens/searchScreen.dart';
import 'package:flutter/material.dart';

class Hometosearch extends ChangeNotifier{

  void onTapONSearch(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
  }
}