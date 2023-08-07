

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  TextEditingController EndDataController=TextEditingController();

  Future<void> getAllTasks()async{
    emit(GetAllTasksLoadingState());
    await DioHelper.getData(endPoint: EndPoints.tasks,token: CashHelper.get(key: LocalKeys.token)).then((value){
      taskModel=TaskModel.fromJson(value.data);
      emit(GetAllTasksSuccessState());
    }).catchError((error){
      print(error.toString());
      if(error is DioException){
        print(error.response?.data);
      }
      emit(GetAllTasksErrorState());
    })
    ;

  }
  Future<void>addTask()async{
    emit(AddTasksLoadingState());
    await DioHelper.postData(endPoint: EndPoints.tasks,
        body: {
      'title':titleController.text,
          'description':descriptionController.text,
          'start_date':startDateController.text,
          'end_date':EndDataController.text,

    }).then((value) {
      print(value.data);
      // Task newTask =Task.fromJson(value.data['response']);
      // taskModel?.tasks?.add(newTask);
      emit(AddTasksSuccessState());
      getAllTasks();
      titleController.clear();
      descriptionController.clear();
      startDateController.clear();
      EndDataController.clear();
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
}
