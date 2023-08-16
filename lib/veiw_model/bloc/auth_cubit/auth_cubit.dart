import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
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
  TextEditingController changePasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
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
      user = User.fromJson(value.data['user']);
      print(user?.name);
      showToast(message: 'Welcome ${user?.name ?? ''}');
      CashHelper.put(
          key: LocalKeys.token, value: value.data['authorisation']['token']);
      CashHelper.put(key: LocalKeys.userName, value: user?.name);
      emit(LoginSuccessState());
    }).catchError((error) {
      print(error.toString());
      if (error is DioException) {
        print(error.response?.data);
        showToast(
            message: error.response?.data['message'] ?? 'there is an error');
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
        'name': registerNameController.text,
        'email': registerEmailController.text,
        'password': registerPasswordController.text,
      },
    ).then((value) {
      registerNameController.clear();
      registerPasswordController.clear();
      registerEmailController.clear();
      print(value.data);
      user = User.fromJson(value.data['user']);
      print(user?.name);
      showToast(message: 'Welcome ${user?.name ?? ''}');
      CashHelper.put(
          key: LocalKeys.token, value: value.data['authorisation']['token']);
      CashHelper.put(key: LocalKeys.userName, value: user?.name);
      emit(RegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      if (error is DioException) {
        print(error.response?.data);
        showToast(
            message: error.response?.data['message'] ?? 'there is an error');
      }
      emit(RegisterErrorState());
      throw error;
    });
  }

  final ImagePicker picker = ImagePicker();

// Pick an image.
  XFile? profileImage;

  Future<void> gitImageFromGallery() async {
    emit(GetImageFromGalleryLoadingState());
    var status = await Permission.photos.status;
    print(status);
    if (status != PermissionStatus.granted) {
      showToast(message: 'you need to allow permission to photos');
      await Permission.photos.request();
      openAppSettings();
    } else {
      profileImage = await picker.pickImage(source: ImageSource.gallery);
      if (profileImage == null) {
        showToast(message: 'image not selected');
        GetImageFromGalleryErrorState();
      } else {
        emit(GetImageFromGallerySuccessState());
      }
    }
  }

  GlobalKey<FormState> updateFormKey = GlobalKey<FormState>();
  TextEditingController updateNameController = TextEditingController();

  Future<void> updateProfile() async {
    emit(UpdateProfilerLoadingState());
    FormData formData = FormData.fromMap({
      'name': registerNameController.text,
      if (profileImage != null)
        'profile_image': await MultipartFile.fromFile(profileImage!.path)
    });
    DioHelper.postData(
            endPoint: EndPoints.updateProfile,
            token: CashHelper.get(key: LocalKeys.token),
            formData: formData)
        .then((value) {
          print(value.data);
          showToast(message: 'updated');
          user = User.fromJson(value.data['0']);
          // user?.name=value.data['0']['name'];
          // user?.profileImage=value.data['0']['profile_image'];
          CashHelper.put(key: LocalKeys.userName, value: value.data['0']['name']);
          CashHelper.put(key: LocalKeys.profileImage, value: profileImage?.path);
      emit(UpdateProfilerSuccessState());
      registerNameController.clear();
      profileImage=null;
    }).catchError((error){
      print(error.toString());
      emit(UpdateProfilerErrorState());
      throw error;
    });
  }
  Future<void>changePassword()async{
    emit(ChangePasswordLoadingState());
    DioHelper.postData(endPoint: EndPoints.changePassword,token: CashHelper.get(key: LocalKeys.token),
      body: {
        'password':changePasswordController.text,
        'confirm_password':confirmPasswordController.text
      }
    ).then((value) {
      emit(ChangePasswordSuccessState());
      showToast(message: 'Password Changed Successfully');
    }).catchError((error){
      print(error.toString());
      emit(ChangePasswordErrorState());
      throw error;
    });
  }

  Future<void>logout()async{
    emit(LogoutLoadingState());
    DioHelper.postData(endPoint: EndPoints.logout,token: CashHelper.get(key: LocalKeys.token),

    ).then((value) {
      emit(LogoutSuccessState());
      showToast(message: 'logout Successfully');
      loginPasswordEmailController.clear();
      loginEmailController.clear();
    }).catchError((error){
      print(error.toString());
      emit(LogoutErrorState());
      throw error;
    });
  }

  Future<void>refresh()async{
    emit(RefreshLoadingState());
    DioHelper.postData(endPoint: EndPoints.refresh,token: CashHelper.get(key: LocalKeys.token),

    ).then((value) {
      emit(RefreshSuccessState());
      showToast(message: 'refresh Successfully');

    }).catchError((error){
      print(error.toString());
      emit(RefreshErrorState());
      throw error;
    });
  }
  bool visible=false;
  void isVisible(){
    visible=(!visible);
    emit(VisibleSuccessState());
  }
}
