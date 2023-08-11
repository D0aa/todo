

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:to_do_app/model/task_model.dart';
import 'package:to_do_app/veiw_model/bloc/tasks_cubit/tasks_state.dart';
import 'package:to_do_app/veiw_model/data/local/cash_helper.dart';
import 'package:to_do_app/veiw_model/data/local/local_keys.dart';
import 'package:to_do_app/veiw_model/data/network/dio_helper.dart';
import 'package:to_do_app/veiw_model/data/network/end_points.dart';
import 'package:to_do_app/view/components/widget/toast_message.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());
  static TasksCubit get(context)=>BlocProvider.of<TasksCubit>(context);
  TaskModel? taskModel;
  GlobalKey<FormState> taskFormKey =GlobalKey<FormState>();

  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  TextEditingController startDateController=TextEditingController();
  TextEditingController endDataController=TextEditingController();

  Future<void> getAllTasks()async{
    emit(GetAllTasksLoadingState());
    await DioHelper.getData(endPoint: EndPoints.tasks,token: CashHelper.get(key: LocalKeys.token)).then((value){
      taskModel=TaskModel.fromJson(value.data);
      emit(GetAllTasksSuccessState());
    }).catchError((error){
      print(error.toString());
      if(error is DioException){
        print(error.response?.data);
        print(error.response?.statusCode);
      }
      emit(GetAllTasksErrorState());
    })
    ;

  }
  Future<void>addTask()async{
    emit(AddTasksLoadingState());
    FormData fromData =FormData.fromMap(
      {
        'title':titleController.text,
        'description':descriptionController.text,
        'start_date':startDateController.text,
        'end_date':endDataController.text,
        if(image !=null)
        'image':await MultipartFile.fromFile(image!.path)
      }
    );

    await DioHelper.postData(endPoint: EndPoints.tasks,
        formData:fromData,
    //     {
    //   'title':titleController.text,
    //       'description':descriptionController.text,
    //       'start_date':startDateController.text,
    //       'end_date':endDataController.text,
    //
    // }
    ).then((value) {
      print(value.data);
      // Task newTask =Task.fromJson(value.data['response']);
      // taskModel?.tasks?.add(newTask);
      emit(AddTasksSuccessState());
      getAllTasks();
      titleController.clear();
      descriptionController.clear();
      startDateController.clear();
      endDataController.clear();
      image =null;
    }).catchError((error){
      print(error.toString());
      if(error is DioException){
        print(error.response?.data);
        showToast(message: error.response?.data['response'].toString() ??'there is an error');
      }
      emit(AddTasksErrorState());
      throw error;
    });
}
  final ImagePicker picker = ImagePicker();
// Pick an image.
   XFile? image ;

   Future<void> gitImageFromGallery() async {
     emit(GetImageFromGalleryLoadingState());
     var status = await Permission.photos.status;
     print(status);
      if(status != PermissionStatus.granted){
        showToast(message: 'you need to allow permission to photos');
        await Permission.photos.request();
        openAppSettings();
      }else {
        image = await picker.pickImage(source: ImageSource.gallery);
        if(image ==null){
          showToast(message: 'image not selected');
              GetImageFromGalleryErrorState();
        }else{
          emit(GetImageFromGallerySuccessState());
        }
        //     .then((value)
        // {
        //   print(value);
        //   if(value!= null){
        //     print(value.name);
        //     print(value.path);
        //     print('image is not null');
        //     emit(GetImageFromGallerySuccessState());
        //   }else{
        //     showToast(message: 'image not selected');
        //     GetImageFromGalleryErrorState();}
        // }).catchError((error){
        //   emit(GetImageFromGalleryErrorState());
        // });
      }
      }
      Future<void> deleteTask(int id) async{
     emit(DeleteTaskLoadingState());

     await DioHelper.deleteData(endPoint: '${EndPoints.tasks}/$id',token: CashHelper.get(key: LocalKeys.token)
     ).then((value) {
       emit(DeleteTaskSuccessState());
       showToast(message: 'task delete successfully');
        getAllTasks();
     }).catchError((error){
       print(error.toString());
       if(error is DioException)
       showToast(message: 'Error on delete ${error.response?.data }');
       emit(DeleteTaskErrorState());
       throw error;
     });
      }

}
