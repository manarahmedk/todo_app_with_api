import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:todo_app/view/components/widgets/text_custom.dart';
import 'package:todo_app/view/screens/edit_task_screen.dart';
import 'package:todo_app/view/screens/todo_screen.dart';
import 'package:todo_app/view_model/bloc/todo_cubit/todo_states.dart';
import 'package:todo_app/view_model/utils/colors.dart';
import 'package:todo_app/view_model/utils/lottie.dart';
import 'package:todo_app/view_model/utils/navigation.dart';
import '../../model/task_model.dart';
import '../../view_model/bloc/todo_cubit/todo_cubit.dart';
import '../components/builders/task_builder.dart';
import 'add_task_screen.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var cubit = ToDoCubit.get(context);
    return BlocProvider.value(
      value: ToDoCubit.get(context)..getAllTasks()..showStatistics(),
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
            int total= cubit.todoModel?.data?.tasks?.length??1;
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
              child:SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding:const  EdgeInsets.all(8),
                      child: CircularPercentIndicator(
                        radius: 160.0,
                        lineWidth: 13.0,
                        animation: true,
                        percent: (cubit.statistics?.data?.New?.toDouble()??1.0/total),
                        center: CircularPercentIndicator(
                          radius: 140.0,
                          lineWidth: 13.0,
                          animation: true,
                          percent: (cubit.statistics?.data?.doing?.toDouble()??1.0/total).toDouble(),
                          center:  CircularPercentIndicator(
                            radius: 120.0,
                            lineWidth: 13.0,
                            animation: true,
                            percent: (cubit.statistics?.data?.compeleted?.toDouble()??1.0/total).toDouble(),
                            center:  CircularPercentIndicator(
                              radius: 100.0,
                              lineWidth: 13.0,
                              animation: true,
                              percent: (cubit.statistics?.data?.outdated?.toDouble()??1.0/total).toDouble(),
                              center: Text(
                                "$total Tasks",
                                style:
                                const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                              ),
                              circularStrokeCap: CircularStrokeCap.butt,
                              progressColor: Colors.redAccent,
                            ),
                            circularStrokeCap: CircularStrokeCap.butt,
                            progressColor: Colors.green,
                          ),
                          circularStrokeCap: CircularStrokeCap.butt,
                          progressColor: Colors.blueAccent,
                        ),
                        circularStrokeCap: CircularStrokeCap.butt,
                        progressColor: Colors.orangeAccent,
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigation.pushAndRemove(context, const ToDoScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.orange,
                          minimumSize: const Size(double.infinity, 50),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        child: const TextCustom(
                          text: 'Go To Tasks',
                          fontSize: 15,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
