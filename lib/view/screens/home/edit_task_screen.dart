import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/veiw_model/bloc/tasks_cubit/tasks_cubit.dart';
import 'package:to_do_app/veiw_model/bloc/tasks_cubit/tasks_state.dart';
import 'package:to_do_app/veiw_model/utils/app_assets.dart';

import 'package:to_do_app/view/components/widget/text_custom.dart';
import 'package:to_do_app/view/components/widget/text_form_field_custom.dart';

import '../../../veiw_model/utils/constant.dart';
import '../../components/widget/elevated_button_custom.dart';

class EditTaskScreen extends StatelessWidget {
  final int id;
  const EditTaskScreen({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    var cubit=TasksCubit.get(context)..getTaskDetails(id);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Image.asset(AppAssets.logoIcon, height: 70),
      ),
      body: BlocConsumer<TasksCubit, TasksState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return cubit.currentTask == null? const Center(child: CircularProgressIndicator.adaptive()):
      SingleChildScrollView(
        child: Form(
          key: TasksCubit.get(context).taskFormKey,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 60.h,
                  ),
                  TextFormFieldCustom(
                    controller: TasksCubit.get(context).titleController,
                    prefixIcon: const Icon(Icons.title),
                    validator: (value) {
                      if ((value ?? '').trim().isEmpty) {
                        return 'Must not be empty';
                      } else {
                        return null;
                      }
                    },
                    labelText: 'title',
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormFieldCustom(
                    controller: TasksCubit.get(context).descriptionController,
                    validator: (value) {
                      if ((value ?? '').trim().isEmpty) {
                        return 'Must not be empty';
                      } else {
                        return null;
                      }
                    },
                    labelText: 'description',
                    prefixIcon: const Icon(Icons.description_outlined),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormFieldCustom(
                    controller: TasksCubit.get(context).startDateController,
                    validator: (value) {
                      if ((value ?? '').trim().isEmpty) {
                        return 'Must not be empty';
                      } else {
                        return null;
                      }
                    },
                    labelText: 'start date',
                    prefixIcon: const Icon(Icons.edit_calendar_outlined),
                    keyboardType: TextInputType.none,
                    onTap: () {
                      showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 10))
                          .then((value) {
                        if (value != null) {
                          TasksCubit.get(context).startDateController.text =
                          '${value.year}/${value.month}/${value.day}';
                        } else {
                          TasksCubit.get(context).startDateController.clear();
                        }
                      });
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormFieldCustom(
                    controller: TasksCubit.get(context).endDataController,
                    validator: (value) {
                      if ((value ?? '').trim().isEmpty) {
                        return 'Must not be empty';
                      } else {
                        return null;
                      }
                    },
                    labelText: 'end date',
                    prefixIcon: const Icon(Icons.edit_calendar_outlined),
                    keyboardType: TextInputType.none,
                    onTap: () {
                      showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 10))
                          .then((value) {
                        if (value != null) {
                          TasksCubit.get(context).endDataController.text =
                          '${value.year}/${value.month}/${value.day}';
                        } else {
                          TasksCubit.get(context).endDataController.clear();
                        }
                      });
                    },
                  ),
                  DropdownButtonFormField(
                    value:cubit.status,
                    items: const [
                      DropdownMenuItem(value:'' ,child:Text('Please, Select statue') ,),
                      DropdownMenuItem(value:'new' ,child:Text('new') ,),
                      DropdownMenuItem(value:'in_progress' ,child:Text('In progress') ,),
                      DropdownMenuItem(value:'completed' ,child:Text('Completed') ,),
                      DropdownMenuItem(value:'outdated' ,child:Text('Outdated') ,),
                    ],
                    validator: (value) {
                      if (value == '') {
                        return 'Must not be empty';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'status',
                      labelStyle: const TextStyle(color: Colors.black),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: Colors.grey, width: 1.w),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: Colors.grey, width: 1.w),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: Colors.grey, width: 2.w),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: Colors.red, width: 1.w),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: Colors.red, width: 2.w),
                      ),
                    ),
                    onChanged:(value) {
                      if(value != null)
                     { cubit.status=value ;}
                  },),
                  SizedBox(
                    height: 10.h,
                  ),
                  Material(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    borderRadius: BorderRadius.circular(12.r),
                    child: InkWell(
                      onTap: () {
                        TasksCubit.get(context).gitImageFromGallery();
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border:
                            Border.all(color: Colors.black45, width: 1.w)),
                        child: BlocConsumer<TasksCubit, TasksState>(
                          listener: (context, state) {
                            // TODO: implement listener
                          },
                          builder: (context, state) {
                            return Column(
                              children: [
                                if (TasksCubit.get(context).image?.path != null)
                                  Image.file(File(
                                      TasksCubit.get(context).image!.path)),
                                if (TasksCubit.get(context).image == null)
                                  Image.asset(iconImage, width: 200.w),
                                SizedBox(
                                  height: 10.h,
                                ),
                                const TextCustom(text: 'Add photo to your note')
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  BlocBuilder<TasksCubit, TasksState>(
                    builder: (context, state) {
                      return Visibility(
                          visible: state is AddTasksLoadingState,
                          child: const LinearProgressIndicator(color: Colors.black,));
                    },
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  ElevatedButtonCustom(
                    onPressed: () {
                      if (TasksCubit.get(context)
                          .taskFormKey
                          .currentState!
                          .validate()) {
                        TasksCubit.get(context)
                            .updateTask(id)
                            .then((value) => Navigator.pop(context));
                      }
                    },
                    text: 'Edit Task',
                    color: const Color(0xff363637),
                    backgroundColor: const Color(0xffFEFE9C),
                  )
                ],
              ),
            ),
          ),
        ),
      );
  },
),
    );
  }
}
