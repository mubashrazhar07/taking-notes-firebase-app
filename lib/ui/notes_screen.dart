import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taking_notes_firebase_app/ui/auth/signin.dart';
import 'package:taking_notes_firebase_app/utils/utils.dart';
class NotesScreen extends StatelessWidget {
  NotesScreen({super.key});
  final _auth= FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        actions: [
          InkWell(
            onTap: (){
              _auth.signOut().then((value) {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignInScreen()));
              }).onError((error, stackTrace){
                Utils().toastMessage(error.toString());
              });
            },
            child:const Icon(Icons.signpost_outlined) ,)
        ],
      ),
      body: const Center(
        child: Text('NOTES SCREEN', style: TextStyle(color: Colors.white),),
      ),
    );
  }
}