import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth/signin.dart';
import 'notes/add_notes_screen.dart';
import 'notes/gridview_listview_toggle.dart';
class SplashServices {
void isLogin(BuildContext context){
 final _auth = FirebaseAuth.instance;
 final user= _auth.currentUser;
  Timer(const Duration(seconds: 2), () {
    if(user!=null){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> GridViewListViewToggle()));
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignInScreen()));
    }

  });
}
}