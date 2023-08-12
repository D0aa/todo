import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/view/components/widget/text_custom.dart';
class KeyWidget extends StatelessWidget {
  final String text;
  final Color color;
   const KeyWidget({required this.color, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(bottom: 5.sp),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              color: color,
            ),
            height: 20.h,
            width: 20.h,
          ),
          SizedBox(width: 20.w,),
          TextCustom(text:text ),
        ],
      ),
    );
  }
}
