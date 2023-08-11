
abstract class TasksState {}

class TasksInitial extends TasksState {}
class GetAllTasksLoadingState extends TasksState{}
class GetAllTasksSuccessState extends TasksState{}
class GetAllTasksErrorState extends TasksState{
  final int? statusCode;

  GetAllTasksErrorState({this.statusCode});
}
class AddTasksLoadingState extends TasksState{}
class AddTasksSuccessState extends TasksState{}
class AddTasksErrorState extends TasksState{}

class GetImageFromGalleryLoadingState extends TasksState{}
class GetImageFromGallerySuccessState extends TasksState{}
class GetImageFromGalleryErrorState extends TasksState{}

class DeleteTaskLoadingState extends TasksState{}
class DeleteTaskSuccessState extends TasksState{}
class DeleteTaskErrorState extends TasksState{}
