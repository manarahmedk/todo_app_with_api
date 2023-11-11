import 'package:flutter/material.dart';
import 'package:todo_app/view/components/widgets/text_custom.dart';
import 'package:todo_app/view_model/utils/colors.dart';
import '../../../model/task_model.dart';
import '../../../view_model/bloc/todo_cubit/todo_cubit.dart';

class TaskBuilder extends StatelessWidget {
  final Task? taskModel;
  void Function()? onTap;

  TaskBuilder({required this.taskModel, this.onTap});

  @override
  Widget build(BuildContext context) {
    var cubit = ToDoCubit.get(context);
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.orange.withOpacity(0.25),
            border: Border.all(
              color: Colors.orange,
              width: 3,
            ),
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextCustom(
                text: taskModel?.title ?? "",
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: AppColors.black,
              ),
              TextCustom(
                text: taskModel?.description ?? "",
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.grey,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.timer_outlined,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  TextCustom(
                    text: taskModel?.startDate ?? "",
                    color: AppColors.black,
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.timer_off_outlined,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  TextCustom(
                    text: taskModel?.endDate ?? "",
                    color: AppColors.black,
                  ),
                ],
              ),
              if((taskModel?.image ?? '').isNotEmpty)
                ...[
                  const SizedBox(
                    height: 12,
                  ),
                  Image.network(taskModel?.image ?? ""),
                ],
              const SizedBox(
                height: 8,
              ),
              TextCustom(
                text: "status : ${taskModel?.status}" ?? "",
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
