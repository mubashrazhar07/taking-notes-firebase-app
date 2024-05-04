import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taking_notes_firebase_app/ui/shared_components/custom_button.dart';
import 'package:taking_notes_firebase_app/utils/utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final forgotPasswordController = TextEditingController();
  bool loading = false;
  final _auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Forgot Password Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: forgotPasswordController,
              decoration: const InputDecoration(
                hintText: 'Enter recovery email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            CustomButton(
        loading: loading,
              buttonText: 'Send Email',
              onTap: () {
          setState(() {
            loading= true;
          });
                _auth.sendPasswordResetEmail(
                    email:forgotPasswordController.text.toString() ).then((value) {
                      setState(() {
                        loading= false;
                      });
                  Utils().toastMessage('Email has been sent');
                }).onError((error, stackTrace){
                  Utils().toastMessage(error.toString());
                  setState(() {
                    loading= false;
                  });
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
