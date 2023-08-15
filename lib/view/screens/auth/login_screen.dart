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
import 'package:to_do_app/view/screens/auth/register_screen.dart';
import 'package:to_do_app/view/screens/home/all_tasks_screen.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  key: cubit.loginFormKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(AppAssets.logoIcon, height: 90.h),
                          Column(
                            children: [
                              const TextCustom(text: 'Don\'t have an account?',fontSize: 14),
                              TextButton(onPressed: (){
                                Navigation.push(context, RegisterScreen());
                              }, child: Text(
                                 'Register',
                                style: TextStyle(decoration: TextDecoration.underline,
                               color: Colors.black ),
                              )),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 10.h),
                      TextCustom(
                          text: 'Login',
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                      SizedBox(height: 10.h),
                      TextFormFieldCustom(
                        labelText: 'Email',
                        controller: cubit.loginEmailController,
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
                        controller: cubit.loginPasswordEmailController,
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
                      state is LoginLoadingState?CircularProgressIndicator.adaptive():
                      ElevatedButtonCustom(
                        onPressed: () {
                          if(cubit.loginFormKey.currentState!.validate()){
                            cubit.userLogin().then((value) => Navigation.pushAndRemove(context, AllTasksScreen()));
                          }
                        },
                        text: 'Login',
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
