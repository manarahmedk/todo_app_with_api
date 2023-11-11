import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:todo_app/view/components/widgets/text_custom.dart';
import 'package:todo_app/view/screens/todo_screen.dart';
import 'package:todo_app/view_model/bloc/todo_cubit/todo_states.dart';
import 'package:todo_app/view_model/utils/colors.dart';
import 'package:todo_app/view_model/utils/navigation.dart';
import '../../view_model/bloc/todo_cubit/todo_cubit.dart';
import '../components/widgets/statistics_widget.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var cubit = ToDoCubit.get(context);
    return BlocProvider.value(
      value: ToDoCubit.get(context)..showStatistics(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.orange,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
          title: const TextCustom(
            text: 'Dashboard Tasks',
          ),
        ),
        body: BlocConsumer<ToDoCubit, ToDoStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return (cubit.statistics?.data !=null) ? SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:const  EdgeInsets.all(8),
                    child: CircularPercentIndicator(
                      radius: 160.0,
                      lineWidth: 13.0,
                      animation: true,
                      percent: (cubit.statistics?.data?.New??1).toDouble()/cubit.total.toDouble(),
                      center: CircularPercentIndicator(
                        radius: 140.0,
                        lineWidth: 13.0,
                        animation: true,
                        percent: (cubit.statistics?.data?.doing??1).toDouble()/cubit.total.toDouble(),
                        center:  CircularPercentIndicator(
                          radius: 120.0,
                          lineWidth: 13.0,
                          animation: true,
                          percent: (cubit.statistics?.data?.compeleted??1).toDouble()/cubit.total.toDouble(),
                          center:  CircularPercentIndicator(
                            radius: 100.0,
                            lineWidth: 13.0,
                            animation: true,
                            percent: (cubit.statistics?.data?.outdated??1).toDouble()/cubit.total.toDouble(),
                            center: Text(
                              "${cubit.total} Tasks",
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
                    height: 40,
                  ),
                  const Column(
                    children: [
                      StatisticsWidget(text:"  New Tasks",color: Colors.orangeAccent, ),
                      StatisticsWidget(text:"  In Progress Tasks",color: Colors.blueAccent, ),
                      StatisticsWidget(text:"  Completed Tasks",color: Colors.green, ),
                      StatisticsWidget(text:"  OutDated Tasks",color: Colors.redAccent, ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
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
                        fontSize: 17,
                        color: AppColors.white,
                      ),
                    ),
                  ),

                ],
              ),
            ): Center(child: Padding(
              padding: const EdgeInsets.all(14.0),
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
                  fontSize: 17,
                  color: AppColors.white,
                ),
              ),
            ));
          },
        ),
      ),
    );
  }
}
