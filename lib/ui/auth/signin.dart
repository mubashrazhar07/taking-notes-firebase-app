import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taking_notes_firebase_app/ui/auth/forgot_password_screen.dart';
import 'package:taking_notes_firebase_app/ui/auth/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taking_notes_firebase_app/utils/theme/constants/app_color.dart';

import 'package:taking_notes_firebase_app/utils/utils.dart';
import '../notes/gridview_listview_toggle.dart';
import '../shared_components/custom_button.dart';
import 'auth_components/auth_title.dart';
import 'auth_components/custom_textfield.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth= FirebaseAuth.instance;
  bool loading =false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
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
                      firstText: 'LOGIN YOUR',
                      secondText: 'ACCOUNT',
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      'Welcome Back!',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    SizedBox(height: 30.h),
                    CustomTextField(
                      hintText: 'Enter your email',
                      fieldLabel: 'Email',
                      controler: emailController,
                      errText: 'Enter Email First',
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                        hintText: 'Enter your password',
                        fieldLabel: 'Password',
                        controler: passwordController,
                        errText: 'Enter Password First'),
                    SizedBox(height: 30.h),
                    CustomButton(loading: loading,
                      buttonText: 'Sign In', onTap: () {
                      setState(() {
                        loading=true;
                      });
                        _auth.signInWithEmailAndPassword(
                            email: emailController.text.toString(),
                            password: passwordController.text.toString()).then((value) {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const GridViewListViewToggle()));
                          Utils().toastMessage('Sign Inned');
                          setState(() {
                            loading=false;
                          });
                        }).onError((error, stackTrace) {
                          setState(() {
                            loading=false;
                          });
                        });
                    },
                    ),
                    SizedBox(height: 10.h),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>const ForgotPasswordScreen()));
                        },
                        child: Text(
                          'Forget Password?',
                          style: TextStyle(color: ksecodaryBlue),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      'or continue with',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Dont have an account-',
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        InkWell(
                          onTap: () {

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUpScreen()));

                          },
                          child: Text(
                            'Register Now',
                            style: TextStyle(
                              color: theme.colorScheme.secondary,
                              decoration: TextDecoration.underline,
                              decorationColor: theme.colorScheme.secondary,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
