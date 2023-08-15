import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_app/model/task_model.dart';
import 'package:to_do_app/veiw_model/bloc/auth_cubit/auth_cubit.dart';
import 'package:to_do_app/veiw_model/bloc/auth_cubit/auth_state.dart';
import 'package:to_do_app/veiw_model/bloc/tasks_cubit/tasks_cubit.dart';
import 'package:to_do_app/veiw_model/bloc/tasks_cubit/tasks_state.dart';
import 'package:to_do_app/veiw_model/data/local/cash_helper.dart';
import 'package:to_do_app/veiw_model/data/local/local_keys.dart';
import 'package:to_do_app/view/components/task/task_wedgit.dart';
import 'package:to_do_app/view/components/widget/text_custom.dart';
import 'package:to_do_app/view/components/widget/toast_message.dart';
import 'package:to_do_app/view/screens/auth/login_screen.dart';
import 'package:to_do_app/view/screens/drawer/change_password.dart';
import 'package:to_do_app/view/screens/drawer/update_profile_screen.dart';
import 'package:to_do_app/view/screens/home/add_task_screen.dart';
import 'package:to_do_app/view/screens/home/edit_task_screen.dart';
import 'package:to_do_app/view/screens/home/tasks_dashboard.dart';

import '../../../veiw_model/utils/navigation.dart';
import '../../components/widget/elevated_button_custom.dart';

class AllTasksScreen extends StatelessWidget {
  const AllTasksScreen({ super.key});
  @override
  Widget build(BuildContext context) {

    // TasksCubit.get(context).getAllTasks();
    var cubit = TasksCubit.get(context);
    return Scaffold(
      drawer: BlocConsumer<AuthCubit, AuthState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(12.sp),
            children: [

              CircleAvatar(
                radius: 70.r,
                backgroundImage:
                Image.file(File(
                      CashHelper.get(key: LocalKeys.profileImage)??''),errorBuilder:
                      (context, error, stackTrace) =>
                      Icon(Icons.person,size: 30.sp)
                    ,).image


              ),
              SizedBox(height: 10.h,),
              TextCustom(text: CashHelper.get(key: LocalKeys.userName),fontSize: 22.sp),
              SizedBox(height: 15.h,),
              Ink(
                color: Colors.grey.withOpacity(.1),
                child: ListTile(
                  leading: Icon(Icons.person_2_rounded),
                  iconColor: Colors.green,
                  title: TextCustom(text: 'Profile'),
                  onTap: (){
                    Navigation.push(context, UpdateProfileScreen());
                  },
                ),
              ),
              SizedBox(height: 10.h,),
              Ink(
                color: Colors.grey.withOpacity(.1),
                child: ListTile(
                  leading: Icon(Icons.password),
                  iconColor: Colors.green,
                  title: TextCustom(text: 'Change Password'),
                  onTap: (){
                    Navigation.push(context, ChangePasswordScreen());
                  },
                ),
              ),
              SizedBox(height: 10.h,),
              Ink(
                color: Colors.grey.withOpacity(.1),
                child: ListTile(
                  leading: Icon(Icons.logout),
                  iconColor: Colors.green,
                  title: TextCustom(text: 'Logout'),
                  onTap: (){
                    Navigation.pushAndRemove(context, const LoginScreen());
                    CashHelper.clearDate();
                  },
                ),
              ),
              SizedBox(height: 10.h,),
            ],
          ),
        ),
      );
  },
),
      appBar: AppBar(
        backgroundColor: const Color(0xffFEFE9C),
        title: const TextCustom(
          text: 'To Do List',
          fontWeight: FontWeight.bold,
          fontSize: 23,
        ),
        centerTitle: false,
        // automaticallyImplyLeading: false,
        // leading: Image.asset(AppAssets.logoIcon, height: 70),
        actions: [
          BlocConsumer<TasksCubit, TasksState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              var cubit=TasksCubit.get(context);
              return IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      barrierColor: Colors.black.withOpacity(.2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20.r))),
                      context: context,
                      builder: (context) => SafeArea(
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.all(12.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const TextCustom(
                                    text: 'Status',
                                    fontWeight: FontWeight.bold),
                                SizedBox(
                                  height: 10.h,
                                ),
                                DropdownButtonFormField(
                                  value: cubit.filterStatus,
                                  items: const [
                                    DropdownMenuItem(
                                      value: '',
                                      child: Text('All Tasks'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'new',
                                      child: Text('new'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'in_progress',
                                      child: Text('In progress'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'completed',
                                      child: Text('Completed'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'outdated',
                                      child: Text('Outdated'),
                                    ),
                                  ],
                                  validator: (value) {
                                    if (value == '') {
                                      return 'Must not be empty';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    labelStyle:
                                        const TextStyle(color: Colors.black),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1.w),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1.w),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2.w),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.w),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2.w),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    if(value != null)
                                    { cubit.filterStatus=value ;}
                                  },
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                ElevatedButtonCustom(
                                  onPressed: () {

                                      cubit.filterTask().then((value) => Navigator.pop(context));

                                  },
                                  text: 'Apply Filter',
                                  color: const Color(0xff363637),
                                  backgroundColor: const Color(0xffFEFE9C),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.filter_alt_rounded));
            },
          ),
          IconButton(onPressed: (){
            Navigation.push(context, TasksDashboardScreen());
          }, icon: const Icon(Icons.dashboard),),
          IconButton(
              onPressed: () {
                Navigation.pushAndRemove(context, const LoginScreen());
                CashHelper.clearDate();
              },
              icon: const Icon(Icons.exit_to_app_rounded)),

        ],
      ),
      body: BlocConsumer<TasksCubit, TasksState>(
        listener: (context, state) {
          if(state is DeleteTaskLoadingState){
            cubit.clearTasks();
          }
          if(state is DeleteTaskSuccessState ){
            cubit.getAllTasks();
          }
          if(state is DeleteTaskErrorState ){
            cubit.getAllTasks();
          }
          if (state is GetAllTasksErrorState && state.statusCode == 422) {
            print('error in get all tasks');
            showToast(message: 'token is expired');
            Navigation.pushAndRemove(context, const LoginScreen());
            CashHelper.clearDate();
          }

        },
        builder: (context, state) {

          return State is GetAllTasksLoadingState
              ? const CircularProgressIndicator.adaptive()
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
                              const Icon(Icons.error_outline),
                        ),
                        const TextCustom(
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
                            child: TaskWidget(
                              task: cubit.taskModel?.tasks?[index] ?? Task(),
                              onTap: () {
                                Navigation.push(
                                    context,
                                    EditTaskScreen(
                                        id: cubit.taskModel?.tasks?[index].id ??
                                            0));
                              },
                            ),
                          ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10.h),
                      itemCount: cubit.taskModel?.tasks?.length ?? 0),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigation.push(context, const AddTaskScreen());
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xffFEFE9C),
      ),
    );
  }
}
