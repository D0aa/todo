import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
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

import '../../../model/fire_model/fire_task.dart';
import '../../../model/fire_model/fire_user.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());

  static TasksCubit get(context) => BlocProvider.of<TasksCubit>(context);
  TaskModel? taskModel;
  GlobalKey<FormState> taskFormKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDataController = TextEditingController();
  String status = '';
  FireUser? currentUser;

  Future<void> getAllTasks() async {
    emit(GetAllTasksLoadingState());
    await DioHelper.getData(
      endPoint: EndPoints.tasks,
      token: CashHelper.get(key: LocalKeys.token),
    ).then((value) {
      taskModel = TaskModel.fromJson(value.data);
      emit(GetAllTasksSuccessState());
      taskDashboard();
    }).catchError((error) {
      print(error.toString());
      if (error is DioException) {
        print(error.response?.data);
        print(error.response?.statusCode);
      }
      emit(GetAllTasksErrorState());
    });
  }

  List<FireTask> fireTasks = [];

  Future<void> getAllFireTasks() async {
    emit(GetAllFireTasksLoadingState());
    await FirebaseFirestore.instance
        .collection('tasks')
        .where('user_id', isEqualTo: CashHelper.get(key: LocalKeys.uid))
        .snapshots()
        .listen((value) {
      fireTasks = [];
      for (var i in value.docs) {
        FireTask task = FireTask.fromJson(i.data(), id: i.id);
        fireTasks.add(task);
        emit(GetAllFireTasksSuccessState());
      }
    });
  }

  int page = 2;
  static bool hasMore = true;
  TaskModel? moreTasks;

  Future<void> getMoreTasks() async {
    emit(GetMoreTasksLoadingState());
    await DioHelper.getData(
      endPoint: EndPoints.tasks,
      token: CashHelper.get(key: LocalKeys.token),
      queryParameters: {
        'page': page,
      },
    ).then((value) {
      moreTasks = TaskModel.fromJson(value.data);
      if ((moreTasks?.tasks ?? []).isEmpty) {
        hasMore = false;
      } else {
        taskModel?.tasks?.addAll(moreTasks?.tasks ?? []);
        page++;
      }
      emit(GetMoreTasksSuccessState());
      taskDashboard();
    }).catchError((error) {
      print(error.toString());
      if (error is DioException) {
        print(error.response?.data);
        print(error.response?.statusCode);
      }
      emit(GetMoreTasksErrorState());
    });
  }

  Future<void> addTask() async {
    emit(AddTasksLoadingState());
    FormData fromData = FormData.fromMap({
      'title': titleController.text,
      'description': descriptionController.text,
      'start_date': startDateController.text,
      'end_date': endDataController.text,
      if (image != null) 'image': await MultipartFile.fromFile(image!.path)
    });

    await DioHelper.postData(
      endPoint: EndPoints.tasks,
      token: CashHelper.get(key: LocalKeys.token),
      formData: fromData,
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
      taskDashboard();
      clearInputs();
    }).catchError((error) {
      print(error.toString());
      if (error is DioException) {
        print(error.response?.data);
        showToast(
            message: error.response?.data['response'].toString() ??
                'there is an error');
      }
      emit(AddTasksErrorState());
      throw error;
    });
  }

  final ImagePicker picker = ImagePicker();

// Pick an image.
  XFile? image;
  String imageUrl = '';

  Future<void> gitImageFromGallery() async {
    emit(GetImageFromGalleryLoadingState());
    var status = await Permission.photos.status;
    print(status);
    if (status != PermissionStatus.granted) {
      showToast(message: 'you need to allow permission to photos');
      await Permission.photos.request();
      openAppSettings();
    } else {
      image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        showToast(message: 'image not selected');
        GetImageFromGalleryErrorState();
      } else {
       await uploadImage(path: 'tasks/${await CashHelper.get(key: LocalKeys.uid)}',
            image: image ?? XFile(''),
            onDone: (value) {
              imageUrl=value;
            },);
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

  // Future<void> gitImageFromGallery() async {
  //   emit(GetImageFromGalleryLoadingState());
  //   var status = await Permission.photos.status;
  //   print(status);
  //   if (status != PermissionStatus.granted) {
  //     showToast(message: 'you need to allow permission to photos');
  //     await Permission.photos.request();
  //     openAppSettings();
  //   } else {
  //     image = await picker.pickImage(source: ImageSource.gallery);
  //     if (image == null) {
  //       showToast(message: 'image not selected');
  //       GetImageFromGalleryErrorState();
  //     } else {
  //       emit(GetImageFromGallerySuccessState());
  //     }
  //     //     .then((value)
  //     // {
  //     //   print(value);
  //     //   if(value!= null){
  //     //     print(value.name);
  //     //     print(value.path);
  //     //     print('image is not null');
  //     //     emit(GetImageFromGallerySuccessState());
  //     //   }else{
  //     //     showToast(message: 'image not selected');
  //     //     GetImageFromGalleryErrorState();}
  //     // }).catchError((error){
  //     //   emit(GetImageFromGalleryErrorState());
  //     // });
  //   }
  // }

  void clearTasks() {
    taskModel = null;
  }

  // void clearFireTasks() {
  //   fireTasks = [];
  // }

  Future<void> deleteFireTask(String id) async {
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(id)
        .delete()
        .then((value) {
      emit(DeleteFireTaskSuccessState());
      getAllFireTasks();
      showToast(message: 'task delete successfully');
      taskFireDashboard();
    }).catchError((error) {
      print(error.toString());
      emit(DeleteFireTaskErrorState());
      throw error;
    });
  }

  Future<void> deleteTask(int id) async {
    emit(DeleteTaskLoadingState());

    await DioHelper.deleteData(
      endPoint: '${EndPoints.tasks}/$id',
      token: CashHelper.get(key: LocalKeys.token),
    ).then((value) {
      emit(DeleteTaskSuccessState());
      showToast(message: 'task delete successfully');
      taskDashboard();
    }).catchError((error) {
      print(error.toString());
      if (error is DioException) {
        showToast(message: 'Error on delete ${error.response?.data}');
      }
      emit(DeleteTaskErrorState());
      throw error;
    });
  }

  Task? currentTask;

  Future<void> getTaskDetails(int id) async {
    emit(GetTaskDetailsLoadingState());
    currentTask == null;
    await DioHelper.getData(
      endPoint: '${EndPoints.tasks}/$id',
      token: CashHelper.get(key: LocalKeys.token),
    ).then((value) {
      currentTask = Task.fromJson(value.data['response']);
      titleController.text = currentTask?.title ?? '';
      descriptionController.text = currentTask?.description ?? '';
      startDateController.text = currentTask?.startDate ?? '';
      endDataController.text = currentTask?.endDate ?? '';
      status = currentTask?.status ?? '';
      emit(GetAllTasksSuccessState());
      taskDashboard();
    }).catchError((error) {
      print(error.toString());
      emit(GetTaskDetailsErrorState());
      throw error;
    });
  }

  void clearInputs() {
    titleController.clear();
    descriptionController.clear();
    startDateController.clear();
    endDataController.clear();
    image = null;
    status = '';
  }

  FireTask? currentFireTask;

  Future<void> getFireTaskDetails(String id) async {
    emit(GetDetailsFireTaskLoadingState());
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(id)
        .get()
        .then((value) {
      currentFireTask = FireTask.fromJson(value.data() ?? {});
      titleController.text = currentFireTask?.title ?? '';
      descriptionController.text = currentFireTask?.description ?? '';
      startDateController.text = currentFireTask?.startDate ?? '';
      endDataController.text = currentFireTask?.endDate ?? '';
      status = currentFireTask?.status ?? '';
      emit(GetDetailsFireTaskSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetDetailsFireTaskErrorState());
      throw error;
    });
  }

  Future<void> updateFireTask(String id) async {
    emit(EditFireTaskLoadingState());
    currentFireTask = FireTask(
      userId: CashHelper.get(key: LocalKeys.uid),
      title: titleController.text,
      description: descriptionController.text,
      startDate: startDateController.text,
      endDate: endDataController.text,
      status: status,
    );
    FirebaseFirestore.instance
        .collection('tasks')
        .doc(id)
        .update(currentFireTask?.toJson() ?? {})
        .then((value) {
      clearInputs();
      showToast(message: 'Task Updated Successfully');
      emit(EditFireTaskSuccessState());
      getAllFireTasks();
      taskFireDashboard();
    }).catchError((error) {
      print(error.toString());
      emit(EditFireTaskErrorState());
      throw error;
    });
  }

  Future<void> updateTask(int id) async {
    emit(EditTaskLoadingState());
    FormData fromData = FormData.fromMap({
      'title': titleController.text,
      'description': descriptionController.text,
      'start_date': startDateController.text,
      'end_date': endDataController.text,
      'status': status,
      '_method': 'PUT',
      if (image != null) 'image': await MultipartFile.fromFile(image!.path)
    });
    await DioHelper.postData(
      endPoint: '${EndPoints.tasks}/$id',
      token: CashHelper.get(key: LocalKeys.token),
      formData: fromData,
    ).then((value) {
      clearInputs();
      showToast(message: 'Task Updated Successfully');
      emit(EditTaskSuccessState());
      getAllTasks();
      taskDashboard();
    }).catchError((error) {
      print(error.toString());
      emit(EditTaskErrorState());
      throw error;
    });
  }

  String filterStatus = '';

  Future<void> filterTask() async {
    emit(FilterTaskLoadingState());
    await DioHelper.getData(
      endPoint: EndPoints.tasks,
      token: CashHelper.get(key: LocalKeys.token),
      queryParameters: {
        if (filterStatus.isNotEmpty) 'status': filterStatus,
      },
    ).then((value) {
      showToast(message: 'Tasks Filtered Successfully');
      taskModel = TaskModel.fromJson(value.data);
      emit(FilterTaskSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(FilterTaskErrorState());
      throw error;
    });
  }

  int newTasks = 0;
  int allTasks = 0;
  int inProgressTasks = 0;
  int completedTasks = 0;
  int outdatedTasks = 0;

  Future<void> taskDashboard() async {
    emit(DashboardTaskLoadingState());
    await DioHelper.getData(
        endPoint: EndPoints.dashboard,
        token: CashHelper.get(key: LocalKeys.token))
        .then((value) {
      newTasks = value.data['0']['new tasks'];
      allTasks = value.data['0']['all tasks'];
      inProgressTasks = value.data['0']['in progress tasks'];
      completedTasks = value.data['0']['completed tasks'];
      outdatedTasks = value.data['0']['outdated tasks'];
    }).catchError((error) {
      print(error.toString());
      emit(DeleteTaskErrorState());
      throw error;
    });
  }

  Future<void> taskFireDashboard() async {
    emit(DashboardFireTaskLoadingState());
    await FirebaseFirestore.instance
        .collection('tasks')
        .where('user_id', isEqualTo: CashHelper.get(key: LocalKeys.uid))
        .get()
        .then((value) {
      allTasks = value.docs.length;
    });
    await FirebaseFirestore.instance
        .collection('tasks')
        .where('user_id', isEqualTo: CashHelper.get(key: LocalKeys.uid))
        .where('status', isEqualTo: 'new')
        .get()
        .then((value) {
      newTasks = value.docs.length;
    });
    await FirebaseFirestore.instance
        .collection('tasks')
        .where('user_id', isEqualTo: CashHelper.get(key: LocalKeys.uid))
        .where('status', isEqualTo: 'in_progress')
        .get()
        .then((value) {
      inProgressTasks = value.docs.length;
    });
    await FirebaseFirestore.instance
        .collection('tasks')
        .where('user_id', isEqualTo: CashHelper.get(key: LocalKeys.uid))
        .where('status', isEqualTo: 'completed')
        .get()
        .then((value) {
      completedTasks = value.docs.length;
    });
    await FirebaseFirestore.instance
        .collection('tasks')
        .where('user_id', isEqualTo: CashHelper.get(key: LocalKeys.uid))
        .where('status', isEqualTo: 'outdated')
        .get()
        .then((value) {
      outdatedTasks = value.docs.length;
    });
    emit(DashboardFireTaskSuccessState());
  }

  Future<void> getProfile() async {
    FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: CashHelper.get(key: LocalKeys.uid))
        .get()
        .then((value) {
      for (var i in value.docs) {
        currentUser = FireUser.fromJson(i.data());
      }
    });
  }

  Future<void> addFireTask() async {
    emit(AddFireTasksLoadingState());
    FireTask task = FireTask(
      userId: await CashHelper.get(key: LocalKeys.uid),
      description: descriptionController.text,
      title: titleController.text,
      startDate: startDateController.text,
      endDate: endDataController.text,
      image: imageUrl,
      status: 'new',
    );
    await FirebaseFirestore.instance
        .collection('tasks')
        .add(task.toJson())
        .then((value) {
      emit(AddFireTasksSuccessState());
      print(value.id);
      showToast(message: 'task added successfully');
      getAllFireTasks();
      taskFireDashboard();
      clearInputs();
    }).catchError((error) {
      print(error.toString());
      if (error is FirebaseException) {
        print(error.message);
        showToast(message: error.message.toString());
      }
      emit(AddFireTasksErrorState());
      throw error;
    });
  }

  Future<void> uploadImage(
      {required String path, required XFile image, required Function(String)onDone}) async {
    await storage.FirebaseStorage.instance.ref().child('$path/${image.name}').putFile(
        File(image.path)).then((value) async {
      await value.ref.getDownloadURL().then((value) {
        onDone(value);
        emit(UploadImageSuccessState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(UploadImageErrorState());
      throw error;
    });
  }

}
