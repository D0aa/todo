
abstract class AuthState {}

class AuthInitial extends AuthState {}
class LoginLoadingState extends AuthState{}
class LoginSuccessState extends AuthState{}
class LoginErrorState extends AuthState{}

class RegisterLoadingState extends AuthState{}
class RegisterSuccessState extends AuthState{}
class RegisterErrorState extends AuthState{}

class GetImageFromGalleryLoadingState extends AuthState{}
class GetImageFromGallerySuccessState extends AuthState{}
class GetImageFromGalleryErrorState extends AuthState{}

class UpdateProfilerLoadingState extends AuthState{}
class UpdateProfilerSuccessState extends AuthState{}
class UpdateProfilerErrorState extends AuthState{}
class ChangePasswordLoadingState extends AuthState{}
class ChangePasswordSuccessState extends AuthState{}
class ChangePasswordErrorState extends AuthState{}

