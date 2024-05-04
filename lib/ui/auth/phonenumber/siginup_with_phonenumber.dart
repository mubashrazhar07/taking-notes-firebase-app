import 'package:flutter/material.dart';
import 'package:taking_notes_firebase_app/ui/auth/phonenumber/verify_code_screen.dart';
import 'package:taking_notes_firebase_app/ui/shared_components/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taking_notes_firebase_app/utils/utils.dart';

class PhoneNumberScreen extends StatefulWidget {
  PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final phoneController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('LogIn With Phone Number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: phoneController,
              decoration: const InputDecoration(
                hintText: '+92 316 770 9859',

                //  helperText: 'enter email e.g @ mub@gmail.com',
                prefixIcon: Icon(Icons.alternate_email),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
                loading: loading,
                buttonText: 'Send Code',
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  _auth.verifyPhoneNumber(
                      phoneNumber: phoneController.text.toString(),
                      verificationCompleted: (_) {},
                      verificationFailed: (e) {
                        setState(() {
                          loading = false;
                        });
                        Utils().toastMessage(e.toString());
                      },
                      codeSent: (String verificationid, int? token) {
                        setState(() {
                          loading = false;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerifyCodeScreen(
                                      verificationidVerify: verificationid,
                                    )));
                      },
                      codeAutoRetrievalTimeout: (e) {
                        setState(() {
                          loading = false;
                        });
                        Utils().toastMessage(e.toString());
                      });
                }),
          ],
        ),
      ),
    );
  }
}
