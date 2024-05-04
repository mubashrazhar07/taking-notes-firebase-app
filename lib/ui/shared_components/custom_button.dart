import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
 final bool loading;
final VoidCallback onTap;
  const CustomButton({super.key, required this.buttonText, this.loading =false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: BorderRadius.circular(30.sp)),
        width: double.infinity,
        height: 50.sp,
        child: Center(
            child: loading ? const CircularProgressIndicator(color: Colors.white,):Text(
              buttonText,
              style: theme.textTheme.headlineLarge!.copyWith(),
            )),
      ),
    );
  }
}
