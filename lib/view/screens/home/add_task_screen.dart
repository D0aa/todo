import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/veiw_model/bloc/tasks_cubit/tasks_cubit.dart';
import 'package:to_do_app/veiw_model/utils/app_assets.dart';
import 'package:to_do_app/view/components/widget/text_form_field_custom.dart';

import '../../components/widget/elevated_button_custom.dart';
class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Image.asset(AppAssets.logoIcon,height: 70),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: TasksCubit.get(context).taskFormKey,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SizedBox(height: 60.h,),
                  TextFormFieldCustom(
                    controller: TasksCubit.get(context).titleController,
                    prefixIcon:Icon(Icons.title),
                    validator: (value) {
                      if((value??'').trim().isEmpty){
                        return'Must not be empty';
                      }else return null;
                    },
                    labelText: 'title',
                  ),
                  SizedBox(height: 10.h,),
                  TextFormFieldCustom(
                      controller: TasksCubit.get(context).descriptionController,
                    validator: (value) {
                      if((value??'').trim().isEmpty){
                        return'Must not be empty';
                      }else return null;
                    },
                    labelText: 'description',
                    prefixIcon:Icon(Icons.description_outlined),
                  ),
                  SizedBox(height: 10.h,),
                  TextFormFieldCustom(
                      controller: TasksCubit.get(context).startDateController,
                    validator: (value) {
                      if((value??'').trim().isEmpty){
                        return'Must not be empty';
                      }else return null;
                    },
                    labelText: 'start date',
                    prefixIcon:Icon(Icons.date_range),
                    keyboardType: TextInputType.none,
                    onTap: (){
                      showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(),
                          lastDate:DateTime(DateTime.now().year+ 10)).then((value) {
                            if(value!=null){
                             TasksCubit.get(context).startDateController.text='${value.year}/${value.month}/${value.day}';
                            }else{TasksCubit.get(context).startDateController.clear();}
                      });
                    },
                  ),
                  SizedBox(height: 10.h,),
                  TextFormFieldCustom(
                      controller: TasksCubit.get(context).EndDataController,
                    validator: (value) {
                      if((value??'').trim().isEmpty){
                        return'Must not be empty';
                      }else return null;
                    },
                    labelText: 'end date',
                    prefixIcon:Icon(Icons.date_range_outlined),
                    keyboardType: TextInputType.none,
                    onTap: (){
                      showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(),
                          lastDate:DateTime(DateTime.now().year+ 10)).then((value) {
                            if(value!=null){
                             TasksCubit.get(context).EndDataController.text='${value.year}/${value.month}/${value.day}';
                            }else{TasksCubit.get(context).EndDataController.clear();}
                      });
                    },
                  ),
                  SizedBox(height: 10.h,),
                  ElevatedButtonCustom(
                    onPressed: () {
                      if(TasksCubit.get(context).taskFormKey.currentState!.validate()){
                        TasksCubit.get(context).addTask().then((value) => Navigator.pop(context));
                      }
                    },
                    text: 'Add Task',
                    color: Color(0xff363637),
                    backgroundColor: Color(0xffFEFE9C),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
