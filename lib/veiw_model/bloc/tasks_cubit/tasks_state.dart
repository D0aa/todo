
abstract class TasksState {}

class TasksInitial extends TasksState {}
class GetAllTasksLoadingState extends TasksState{}
class GetAllTasksSuccessState extends TasksState{}
class GetAllTasksErrorState extends TasksState{}
class AddTasksLoadingState extends TasksState{}
class AddTasksSuccessState extends TasksState{}
class AddTasksErrorState extends TasksState{}
