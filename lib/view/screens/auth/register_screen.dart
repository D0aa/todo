import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/veiw_model/bloc/auth_cubit/auth_cubit.dart';
import 'package:to_do_app/veiw_model/bloc/auth_cubit/auth_state.dart';
import 'package:to_do_app/veiw_model/utils/app_assets.dart';
import 'package:to_do_app/veiw_model/utils/navigation.dart';
import 'package:to_do_app/view/components/widget/elevated_button_custom.dart';
import 'package:to_do_app/view/components/widget/text_custom.dart';
import 'package:to_do_app/view/components/widget/text_form_field_custom.dart';
import 'package:to_do_app/view/screens/auth/login_screen.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.sp),
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                var cubit = AuthCubit.get(context);
                return Form(
                  key: cubit.registerFormKey,
                  child: Column(
                    children: [
                      Image.asset(AppAssets.logoIcon, height: 150.h),
                      SizedBox(height: 10.h),
                      TextCustom(
                          text: 'Register',
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                      SizedBox(height: 10.h),
                      TextFormFieldCustom(
                        labelText: 'Name',
                        controller: cubit.registerNameController,
                        keyboardType: TextInputType.name,
                        validator: (String? value) {
                          if ((value ?? '').isEmpty) {
                            return 'name is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),
                      TextFormFieldCustom(
                        labelText: 'Email',
                        controller: cubit.registerEmailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? value) {
                          if ((value ?? '').isEmpty) {
                            return 'email is required';
                          } else if (!(RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value ?? ''))) {
                            return 'email is invalid';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),
                      TextFormFieldCustom(
                        controller: cubit.registerPasswordController,
                        labelText: 'Password',
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
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
                      state is RegisterLoadingState?CircularProgressIndicator.adaptive():
                      ElevatedButtonCustom(
                        onPressed: () {
                          if(cubit.registerFormKey.currentState!.validate()){
                            cubit.userRegister().then((value) => Navigator.pop(context));
                          }
                        },
                        text: 'Register',
                        color: Color(0xff363637),
                        backgroundColor: Color(0xffFEFE9C),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
