import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/model/user.dart';
import 'package:to_do_app/veiw_model/bloc/auth_cubit/auth_state.dart';
import 'package:to_do_app/veiw_model/data/local/cash_helper.dart';
import 'package:to_do_app/veiw_model/data/local/local_keys.dart';
import 'package:to_do_app/veiw_model/data/network/dio_helper.dart';
import 'package:to_do_app/veiw_model/data/network/end_points.dart';
import 'package:to_do_app/view/components/widget/toast_message.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordEmailController = TextEditingController();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerNameController = TextEditingController();
  User? user;

  Future<void> userLogin() async {
    emit(LoginLoadingState());
    await DioHelper.postData(
      endPoint: EndPoints.login,
      body: {
        'email': loginEmailController.text,
        'password': loginPasswordEmailController.text,
      },
    ).then((value) {
      print(value.data);
      user =User.fromJson(value.data['user']);
      print(user?.name);
      showToast(message: 'Welcome ${user?.name ?? ''}');
      CashHelper.put(key: LocalKeys.token, value: value.data['authorisation']['token']);
      CashHelper.put(key: LocalKeys.userName, value: user?.name);
      emit(LoginSuccessState());
    }).catchError((error){
      print(error.toString());
      if(error is DioException){
        print(error.response?.data);
        showToast(message:error.response?.data['message']??'there is an error' );
      }
      emit(LoginErrorState());
      throw error;
    });
  }

  Future<void> userRegister() async {
    emit(RegisterLoadingState());
    await DioHelper.postData(
      endPoint: EndPoints.register,
      body: {
        'name' :registerNameController.text,
        'email': registerEmailController.text,
        'password': registerPasswordController.text,
      },
    ).then((value) {
      print(value.data);
      user =User.fromJson(value.data['user']);
      print(user?.name);
      showToast(message: 'Welcome ${user?.name ?? ''}');
      CashHelper.put(key: LocalKeys.token, value: value.data['authorisation']['token']);
      CashHelper.put(key: LocalKeys.userName, value: user?.name);
      emit(RegisterSuccessState());
    }).catchError((error){
      print(error.toString());
      if(error is DioException){
        print(error.response?.data);
        showToast(message:error.response?.data['message']??'there is an error' );
      }
      emit(RegisterErrorState());
      throw error;
    });
  }
}
