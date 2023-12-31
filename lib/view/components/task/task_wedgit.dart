import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:to_do_app/veiw_model/utils/constant.dart';
import 'package:to_do_app/view/components/widget/text_custom.dart';

import '../../../model/fire_model/fire_task.dart';
import '../../../model/task_model.dart';

class TaskWidget extends StatelessWidget {
  final FireTask task;
  final void Function()? onTap;

  const TaskWidget({required this.task, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12.sp),
      color: Colors.grey.withOpacity(.05),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(12.sp),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.sp),
              border: Border.all(
                  color: checkStatus(task.status ?? ''), width: .5.w)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextCustom(
                text: task.title ?? '',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              TextCustom(
                text: task.description ?? '',
                fontSize: 14,
                color: Colors.grey,
                maxLines: 2,
              ),
              Visibility(
                  visible: task.image != null,
                  child: Image.network(
                    '${task.image}',
                    // '$baseImageUrl${task.image}',
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error_outline),
                  )),
              SizedBox(
                height: 10.h,
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                          height: double.infinity,
                          padding: EdgeInsets.all(8.sp),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.sp),
                              border: Border.all(
                                  color: checkStatus(task.status ?? ''),
                                  width: .5.w)),
                          child: Row(
                            children: [
                              const Icon(Icons.timer_outlined),
                              Expanded(
                                  child: TextCustom(
                                      text: task.startDate ?? '', maxLines: 2)),
                            ],
                          )),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Container(
                          height: double.infinity,
                          padding: EdgeInsets.all(8.sp),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.sp),
                              border: Border.all(
                                  color: checkStatus(task.status ?? ''),
                                  width: .5.w)),
                          child: Row(
                            children: [
                              const Icon(Icons.timer_off_outlined),
                              Expanded(
                                  child: TextCustom(
                                text: task.endDate ?? '',
                              )),
                            ],
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Color checkStatus(String status) {
  switch (status) {
    case 'new':
      return Colors.blue;
    case 'in_progress':
      return Colors.lime;
    case 'completed':
      return Colors.green;
    case 'outdated':
      return Colors.deepOrange;
    default:
      return Colors.black;
  }
}
