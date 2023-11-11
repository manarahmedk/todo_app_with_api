import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/view/components/widgets/text_custom.dart';
import 'package:todo_app/view/screens/edit_task_screen.dart';
import 'package:todo_app/view_model/bloc/todo_cubit/todo_states.dart';
import 'package:todo_app/view_model/utils/colors.dart';
import 'package:todo_app/view_model/utils/lottie.dart';
import 'package:todo_app/view_model/utils/navigation.dart';
import '../../model/task_model.dart';
import '../../view_model/bloc/todo_cubit/todo_cubit.dart';
import '../components/builders/task_builder.dart';
import 'add_task_screen.dart';

class ToDoScreen extends StatelessWidget {
  const ToDoScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var cubit = ToDoCubit.get(context);
    return BlocProvider.value(
      value: ToDoCubit.get(context)..getAllTasks(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.orange,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
          title: const TextCustom(
            text: 'To Do App',
          ),
        ),
        body: BlocConsumer<ToDoCubit, ToDoStates>(
          listener: (context, state) {},
          builder: (context, state) {
            //print(cubit.todoModel?.data?.tasks?.length);
            return Visibility(
              visible: cubit.todoModel?.data?.tasks?.isNotEmpty??true,
              replacement: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.network(AppLotties.empty),
                    const TextCustom(
                      text: 'No Tasks Added !',
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: AppColors.orange,
                    ),
                  ],
                ),
              ),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return TaskBuilder(
                      taskModel: cubit.todoModel?.data?.tasks?[index]?? Task(),
                      onTap: () {
                        cubit.changeIndex(index);
                        Navigation.push(context, EditTaskScreen(
                          taskModel: cubit.todoModel?.data?.tasks?[index]?? Task(),
                        ));
                      },
                    );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(
                      height: 8,
                    ),
                itemCount: cubit.todoModel?.data?.tasks?.length??0,
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigation.push(context, AddTaskScreen());
          },
          backgroundColor: AppColors.orange,
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
