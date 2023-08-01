import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormFieldCustom extends StatelessWidget {
  final String? labelText;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final double? redius;

  const TextFormFieldCustom(
      {this.keyboardType,
      this.textInputAction = TextInputAction.next,
      this.obscureText = false,
      this.labelText,
      this.prefixIcon,
      this.validator,
      this.controller,
      this.onTap,
        this.redius=12,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        textInputAction: textInputAction,
        obscureText: obscureText,
        keyboardType: keyboardType,
        onTap: onTap,
        controller: controller,
        style: TextStyle(color: Colors.black),
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: prefixIcon,
          labelStyle: TextStyle(color: Colors.black),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(redius!.r),
            borderSide: BorderSide(color: Colors.grey, width: 1.w),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(redius!.r),
            borderSide: BorderSide(color: Colors.grey, width: 1.w),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(redius!.r),
            borderSide: BorderSide(color: Colors.grey, width: 2.w),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(redius!.r),
            borderSide: BorderSide(color: Colors.red, width: 1.w),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(redius!.r),
            borderSide: BorderSide(color: Colors.red, width: 2.w),
          ),
        ),
      ),
    );
  }
}
