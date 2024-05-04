import 'package:flutter/material.dart';
import 'package:taking_notes_firebase_app/ui/notes_screen.dart';
import 'package:taking_notes_firebase_app/ui/shared_components/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taking_notes_firebase_app/utils/utils.dart';
class VerifyCodeScreen extends StatefulWidget {
  String verificationidVerify;


  VerifyCodeScreen({super.key,required this.verificationidVerify });

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final _auth = FirebaseAuth.instance;
  bool loading = false;
  final codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Verify Code Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              controller: codeController,
              decoration: const InputDecoration(
                hintText: '6 digits code',

                //  helperText: 'enter email e.g @ mub@gmail.com',
                prefixIcon: Icon(Icons.alternate_email),
              ),
            ),
            SizedBox(
              height: 30,
            ),
           CustomButton(buttonText: 'Verify', onTap: ()async{
             setState(() {
               loading=true;
             });
             final credential=PhoneAuthProvider.credential(
                 verificationId:widget.verificationidVerify , 
                 smsCode: codeController.text.toString()
             );
             try{
              await  _auth.signInWithCredential(credential);
               Navigator.push(context, MaterialPageRoute(builder: (context)=>NotesScreen()));
             }catch(e){
               setState(() {
                 loading=false;
               });
               Utils().toastMessage(e.toString());
             }
            
           })
          ],
        ),
      ),
    );
  }
}
