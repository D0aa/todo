
abstract class TasksState {}

class TasksInitial extends TasksState {}
class GetAllTasksLoadingState extends TasksState{}
class GetAllTasksSuccessState extends TasksState{}
class GetAllTasksErrorState extends TasksState{
  final int? statusCode;

  GetAllTasksErrorState({this.statusCode});
}

class GetAllFireTasksLoadingState extends TasksState{}
class GetAllFireTasksSuccessState extends TasksState{}
class GetAllFireTasksErrorState extends TasksState{}

class GetMoreTasksLoadingState extends TasksState{}
class GetMoreTasksSuccessState extends TasksState{}
class GetMoreTasksErrorState extends TasksState{
  final int? statusCode;

  GetMoreTasksErrorState({this.statusCode});
}



class AddTasksLoadingState extends TasksState{}
class AddTasksSuccessState extends TasksState{}
class AddTasksErrorState extends TasksState{}

class AddFireTasksLoadingState extends TasksState{}
class AddFireTasksSuccessState extends TasksState{}
class AddFireTasksErrorState extends TasksState{}

class GetImageFromGalleryLoadingState extends TasksState{}
class GetImageFromGallerySuccessState extends TasksState{}
class GetImageFromGalleryErrorState extends TasksState{}

class DeleteTaskLoadingState extends TasksState{}
class DeleteTaskSuccessState extends TasksState{}
class DeleteTaskErrorState extends TasksState{}

class DeleteFireTaskLoadingState extends TasksState{}
class DeleteFireTaskSuccessState extends TasksState{}
class DeleteFireTaskErrorState extends TasksState{}

class GetTaskDetailsLoadingState extends TasksState{}
class GetTaskDetailsSuccessState extends TasksState{}
class GetTaskDetailsErrorState extends TasksState{}



class EditTaskLoadingState extends TasksState{}
class EditTaskSuccessState extends TasksState{}
class EditTaskErrorState extends TasksState{}

class EditFireTaskLoadingState extends TasksState{}
class EditFireTaskSuccessState extends TasksState{}
class EditFireTaskErrorState extends TasksState{}

class GetDetailsFireTaskLoadingState extends TasksState{}
class GetDetailsFireTaskSuccessState extends TasksState{}
class GetDetailsFireTaskErrorState extends TasksState{}

class FilterTaskLoadingState extends TasksState{}
class FilterTaskSuccessState extends TasksState{}
class FilterTaskErrorState extends TasksState{}

class DashboardTaskLoadingState extends TasksState{}
class DashboardTaskSuccessState extends TasksState{}
class DashboardTaskErrorState extends TasksState{}

class DashboardFireTaskLoadingState extends TasksState{}
class DashboardFireTaskSuccessState extends TasksState{}
class DashboardFireTaskErrorState extends TasksState{}

class UploadImageLoadingState extends TasksState{}
class UploadImageSuccessState extends TasksState{}
class UploadImageErrorState extends TasksState{}

