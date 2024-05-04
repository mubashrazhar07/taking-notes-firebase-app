import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taking_notes_firebase_app/ui/auth/phonenumber/siginup_with_phonenumber.dart';
import 'package:taking_notes_firebase_app/ui/auth/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taking_notes_firebase_app/utils/utils.dart';
import '../notes/gridview_listview_toggle.dart';
import '../shared_components/custom_button.dart';
import 'auth_components/auth_title.dart';
import 'auth_components/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.h),
                      const AuthScreenTitle(
                        firstText: 'CREATE YOUR',
                        secondText: ' ACCOUNT',
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        'Dont worry, well have you up \nand running in no time',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      CustomTextField(
                        hintText: 'Enter your email',
                        fieldLabel: 'Email',
                        controler: emailController,
                        errText: 'Enter Email First',
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextField(
                        hintText: 'Enter your password',
                        fieldLabel: 'Password',
                        controler: passwordController,
                        errText: 'Enter Password First',
                      ),
                      SizedBox(height: 10.h),
                      CustomButton(
                        buttonText: 'Sign Up',
                        loading: loading,
                        onTap: () {
                          setState(() {
                            loading = true;
                          });
                          _auth
                              .createUserWithEmailAndPassword(
                                  email: emailController.text.toString(),
                                  password: passwordController.text.toString())
                              .then((value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const GridViewListViewToggle()));
                            setState(() {
                              Utils().toastMessage('User created');
                              loading = false;
                            });
                          }).onError((error, stackTrace) {
                            Utils().toastMessage(error.toString());
                            setState(() {
                              loading = false;
                            });
                          });
                        },
                      ),
                      SizedBox(
                        height: 43.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account-',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignInScreen()));
                            },
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                color: theme.colorScheme.secondary,
                                decoration: TextDecoration.underline,
                                decorationColor: theme.colorScheme.secondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'or continue with',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomButton(
                          buttonText: 'Login With PhoneNumber',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PhoneNumberScreen()));
                          })
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
