import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/view/components/widget/text_custom.dart';
class ElevatedButtonCustom extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final double width;
  final double height;
  final double radius;
  final Color? backgroundColor;
  final Color? color;
  const ElevatedButtonCustom({required this.onPressed,required this.text,this.radius=12,
    this.backgroundColor,
    this.color,
    this.width=double.infinity,this.height=55, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      width: width.w,
      child: ElevatedButton(onPressed: onPressed, child: TextCustom(
        text: text,
        color: color,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius.r)
        )
      )),
    );
  }
}
