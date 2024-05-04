import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/theme/constants/app_color.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String fieldLabel;
  final controler;
  final String errText;

  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.fieldLabel,
      required this.controler,
      required this.errText});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldLabel,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: kWhiteColor,
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          // height: 54.h,
          child: TextFormField(
            controller: controler,
            validator: (value) {
              if (value!.isEmpty) {
                return errText;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xff1f1f1f),
              hintText: hintText,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xffC7C7C7),
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  // width: 2,
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: theme.colorScheme.secondary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            /*   validator: (value) {
              if (value!.isEmpty) {
                return 'Field cannot be empty';
              } else {
                return null;
              }
            }, */
          ),
        ),
      ],
    );
  }
}
