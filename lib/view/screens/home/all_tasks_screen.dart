import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_app/model/task_model.dart';
import 'package:to_do_app/veiw_model/bloc/tasks_cubit/tasks_cubit.dart';
import 'package:to_do_app/veiw_model/bloc/tasks_cubit/tasks_state.dart';
import 'package:to_do_app/veiw_model/data/local/cash_helper.dart';
import 'package:to_do_app/view/components/task/task_wedgit.dart';
import 'package:to_do_app/view/components/widget/text_custom.dart';
import 'package:to_do_app/view/components/widget/toast_message.dart';
import 'package:to_do_app/view/screens/auth/login_screen.dart';
import 'package:to_do_app/view/screens/home/add_task_screen.dart';

import '../../../veiw_model/utils/navigation.dart';

class AllTasksScreen extends StatelessWidget {
  const AllTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TasksCubit.get(context).getAllTasks();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFEFE9C),
        title: TextCustom(
          text: 'To Do List',
          fontWeight: FontWeight.bold,
          fontSize: 23,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigation.pushAndRemove(context, LoginScreen());
                CashHelper.clearDate();
              },
              icon: Icon(Icons.exit_to_app_rounded))
        ],
      ),
      body: BlocConsumer<TasksCubit, TasksState>(
        listener: (context, state) {
          if (state is GetAllTasksErrorState && state.statusCode == 422) {
            print('error in get all tasks');
            showToast(message: 'token is expired');
            Navigation.pushAndRemove(context, LoginScreen());
            CashHelper.clearDate();
          }
        },
        builder: (context, state) {
          var cubit = TasksCubit.get(context);
          return State is GetAllTasksLoadingState
              ? CircularProgressIndicator.adaptive()
              : Visibility(
                  visible: cubit.taskModel?.tasks?.length != 0,
                  replacement: SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.network(
                          'https://lottie.host/5d5fd84b-cb7f-4eda-9044-16582e6a1b34/mS260alA1q.json',
                          repeat: false,
                          height: 200.h,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.error_outline),
                        ),
                        TextCustom(
                          text: 'No Tasks yet, Please add some tasks',
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  child: ListView.separated(
                      padding: EdgeInsets.all(12.sp),
                      itemBuilder: (context, index) => Dismissible(
                            key: UniqueKey(),
                            child: TaskWidget(
                              task: cubit.taskModel?.tasks?[index] ?? Task(),
                            ),
                            background: Container(
                              color: Colors.red,
                              child: Icon(Icons.delete_rounded,
                                  color: Colors.white, size: 50.sp),
                            ),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) async {
                              await cubit.deleteTask(
                                  cubit.taskModel?.tasks?[index].id ?? 0);
                            },
                          ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10.h),
                      itemCount: cubit.taskModel?.tasks?.length ?? 0),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigation.push(context, AddTaskScreen());
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xffFEFE9C),
      ),
    );
  }
}
