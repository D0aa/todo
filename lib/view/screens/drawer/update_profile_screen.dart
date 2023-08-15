import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../veiw_model/bloc/auth_cubit/auth_cubit.dart';
import '../../../veiw_model/bloc/auth_cubit/auth_state.dart';
import '../../../veiw_model/utils/constant.dart';
import '../../components/widget/elevated_button_custom.dart';
import '../../components/widget/text_custom.dart';
import '../../components/widget/text_form_field_custom.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AuthCubit.get(context);
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Form(
              key: cubit.updateFormKey,
              child: ListView(
                padding: EdgeInsets.all(12.sp),
                children: [
                  Material(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    borderRadius: BorderRadius.circular(12.r),
                    child: InkWell(
                      onTap: () {
                        cubit.gitImageFromGallery();
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border:
                            Border.all(color: Colors.black45, width: 1.w)),
                        child: Column(
                          children: [
                            if (cubit.profileImage?.path != null)
                              Image.file(File(
                                  cubit.profileImage!.path)),
                            if (cubit.profileImage == null)
                              Image.asset(iconImage, width: 200.w),
                            SizedBox(
                              height: 10.h,
                            ),
                            const TextCustom(text: 'Add photo to your profile')
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  TextFormFieldCustom(
                    labelText: 'Name',
                    controller:cubit.registerNameController,
                    keyboardType: TextInputType.name,
                    validator: (String? value) {
                      if ((value ?? '').isEmpty) {
                        return 'name is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.h),
                  ElevatedButtonCustom(
                    onPressed: () {
                    if(cubit.updateFormKey.currentState!.validate())
                      {
                        cubit.updateProfile().then((value) => Navigator.pop(context));
                      }    
                    },
                    text: 'Update Profile',
                    color: const Color(0xff363637),
                    backgroundColor: const Color(0xffFEFE9C),
                  )

                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
