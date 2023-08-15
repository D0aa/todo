import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/veiw_model/bloc/auth_cubit/auth_cubit.dart';
import 'package:to_do_app/veiw_model/bloc/auth_cubit/auth_state.dart';

import '../../../veiw_model/utils/app_assets.dart';
import '../../components/widget/elevated_button_custom.dart';
import '../../components/widget/text_form_field_custom.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit=AuthCubit.get(context);
    return Scaffold(
      body: SafeArea(child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Form(
            key: cubit.passwordFormKey,
            child: ListView(
              padding: EdgeInsets.all(12.sp),
              children: [
                SizedBox(height: 10.h,),
                Image.asset(AppAssets.logoIcon, height: 120.h),
                TextFormFieldCustom(
                  controller: cubit.changePasswordController,
                  obscureText: true,
                  labelText: 'Password',
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value) {
                    if ((value ?? '').isEmpty) {
                      return 'Password is required';
                      // } else if (!(RegExp(
                      //         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                      //     .hasMatch(value ?? ''))) {
                      //   return 'Password is invalid';
                    } else if (value!.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                TextFormFieldCustom(
                  controller: cubit.confirmPasswordController,
                  obscureText: true,
                  labelText: 'Password',
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value) {
                    if ((value ?? '').isEmpty) {
                      return 'Password is required';
                      // } else if (!(RegExp(
                      //         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                      //     .hasMatch(value ?? ''))) {
                      //   return 'Password is invalid';
                    } else if (value!.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                ElevatedButtonCustom(
                  onPressed: () {
                    if( cubit.passwordFormKey.currentState!.validate()){
                      cubit.changePassword().then((value) => Navigator.pop(context));
                    }
                  },
                  text: 'Change Password',
                  color: Color(0xff363637),
                  backgroundColor: Color(0xffFEFE9C),
                )
              ],
            ),
          );
        },
      )),
    );
  }
}
