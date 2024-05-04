import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taking_notes_firebase_app/ui/auth/signup.dart';
import 'package:taking_notes_firebase_app/ui/shared_components/custom_button.dart';
import 'package:taking_notes_firebase_app/ui/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   SplashServices functionCalling= SplashServices();
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    functionCalling.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/splashscreenimage.png',
            height: 350,
          ),
          Text(
            'Make You Best Notes',
            style: theme.textTheme.headlineLarge!.copyWith(),
          ),
          SizedBox(
            height: 10.sp,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              ' Your go-to for condensed and precise summaries. Powered by advanced language models.',
              style: theme.textTheme.labelSmall!
                  .copyWith(color: Colors.white, fontSize: 10.sp),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 25.sp,
          ),
          CustomButton(
            buttonText: 'Get Started', onTap: () {  Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUpScreen()));},
          ),
        ],
      ),
    ));
  }
}
