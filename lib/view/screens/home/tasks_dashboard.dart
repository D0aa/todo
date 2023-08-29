import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:to_do_app/veiw_model/bloc/tasks_cubit/tasks_cubit.dart';
import 'package:to_do_app/veiw_model/bloc/tasks_cubit/tasks_state.dart';
import 'package:to_do_app/view/components/widget/elevated_button_custom.dart';
import 'package:to_do_app/view/components/widget/key_wedget.dart';
import 'package:to_do_app/view/components/widget/text_custom.dart';
import 'package:to_do_app/view/screens/home/all_tasks_screen.dart';

import '../../../veiw_model/data/local/cash_helper.dart';
import '../../../veiw_model/utils/navigation.dart';
import '../../components/widget/toast_message.dart';
import '../auth/login_screen.dart';

class TasksDashboardScreen extends StatelessWidget {
  const TasksDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit=TasksCubit.get(context);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: BlocConsumer<TasksCubit, TasksState>(
            listener: (context, state) {
              if(cubit.allTasks==0){
                cubit.allTasks=1;
              }
              if(state is DashboardFireTaskSuccessState){
                cubit.taskFireDashboard();
              }
              // if(state is DeleteTaskSuccessState){
              //   cubit.taskDashboard();
              // }
              // if(state is EditTaskSuccessState){
              //   cubit.taskDashboard();
              // }
              // if (state is GetAllTasksErrorState && state.statusCode == 422) {
              //   print('error in get all tasks');
              //   showToast(message: 'token is expired');
              //   Navigation.pushAndRemove(context, const LoginScreen());
              //   CashHelper.clearDate();
              // }
            },
            builder: (context, state) {

              return ListView(
                padding: EdgeInsets.all(20.sp),
                children: [
                  SizedBox(height: 10.h,),
                  const TextCustom(
                      text: 'Tasks DashBoard',
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                  SizedBox(
                    height: 40.h,
                  ),
                  //all
                   CircularPercentIndicator(
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.blue,
                      radius: 140.0,
                      lineWidth: 11.0,
                      animation: true,
                      percent: cubit.newTasks/cubit.allTasks,
                      //in progress
                      center: CircularPercentIndicator(
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.lime,
                        radius: 120.0,
                        lineWidth: 13.0,
                        animation: true,
                        percent: cubit.inProgressTasks/cubit.allTasks,
                        //completed
                        center: CircularPercentIndicator(
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: Colors.green,
                          radius: 100.0,
                          lineWidth: 13.0,
                          animation: true,
                          percent: cubit.completedTasks/cubit.allTasks,
                          //outdated
                          center: CircularPercentIndicator(
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: Colors.deepOrange,
                            radius: 80.0,
                            lineWidth: 13.0,
                            animation: true,
                            percent: cubit.outdatedTasks/cubit.allTasks,
                            center: TextCustom(text: '${cubit.allTasks}' ),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 20.h,),
                  const KeyWidget(color: Colors.blue, text: 'new'),
                  const KeyWidget(color: Colors.lime, text: 'in progress'),
                  const KeyWidget(color: Colors.green, text: 'completed'),
                  const KeyWidget(color: Colors.deepOrange, text: 'outdated'),
                  SizedBox(height: 20.h,),
                  ElevatedButtonCustom(
                    onPressed: () {
                      Navigation.push(context, const AllTasksScreen());
                      }, text: 'Go To Tasks',
                    color: const Color(0xff363637),
                    backgroundColor: const Color(0xffFEFE9C),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
