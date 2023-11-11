import 'package:flutter/material.dart';
import 'package:todo_app/view/screens/login_screen.dart';
import 'package:todo_app/view/screens/statistics_screen.dart';
import 'package:todo_app/view/screens/todo_screen.dart';
import 'package:todo_app/view_model/utils/colors.dart';
import '../../view_model/data/local/shared_keys.dart';
import '../../view_model/data/local/shared_prefernce.dart';
import '../../view_model/utils/navigation.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5), () {
      Navigation.pushAndRemove(context,(LocalData.get(key:SharedKeys.token)!= null ?StatisticsScreen():LoginScreen()),);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Image.network(
          'https://cdn.icon-icons.com/icons2/1542/PNG/512/todo_107301.png',
        ),
      ),
    );
  }
}