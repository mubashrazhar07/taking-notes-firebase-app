import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class AuthScreenTitle extends StatelessWidget {
  final String firstText;
  final String secondText;

  const AuthScreenTitle({
    super.key,
    required this.firstText,
    required this.secondText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Text(
          textAlign:TextAlign.center,
          firstText,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 22.sp,
          ),
        ),
        const SizedBox(width: 4,),
        Text(
          textAlign:TextAlign.center,
          secondText,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.secondary,
            fontSize: 22.sp,
          ),
        ),
      ],
    );
  }
}

