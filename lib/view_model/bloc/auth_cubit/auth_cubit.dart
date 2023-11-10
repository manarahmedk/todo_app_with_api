import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/view_model/data/local/shared_keys.dart';
import 'package:todo_app/view_model/data/local/shared_prefernce.dart';
import 'package:todo_app/view_model/data/network/dio_helper.dart';
import 'package:todo_app/view_model/data/network/end_points.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

  TextEditingController nameController2 = TextEditingController();
  TextEditingController emailController2 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  TextEditingController confirmPasswordController2 = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  Future<void> login() async {
    emit(LoginLoadingState());

    await DioHelper.post(
      endPoint: EndPoints.loginWithApi,
      body: {
        'email': emailController.text,
        'password': passwordController.text,
      },
    ).then((value) {
      print(value?.data);
      saveDataToLocal(value?.data);
      emit(LoginSuccessState());
    }).catchError((error) {
      if (error is DioException) {
        print(error.response?.data);
      }
      print(error);
      emit(LoginErrorState());
      throw error;
    });
  }

  void saveDataToLocal(Map<String,dynamic> value){
    LocalData.set(key: SharedKeys.token, value: value['data']['token']);
    LocalData.set(key: SharedKeys.userID, value: value['data']['user']['id']);
    LocalData.set(key: SharedKeys.name, value: value['data']['user']['name']);
    LocalData.set(key: SharedKeys.email, value: value['data']['user']['email']);
  }

  Future<void> registerWithApi() async {
    emit(RegisterLoadingState());
    await DioHelper.post(
      endPoint: EndPoints.register,
      body: {
        'name': nameController2.text,
        'email':emailController2.text,
        'password': passwordController2.text,
        'password_confirmation': confirmPasswordController2.text,
      },
    ).then((value) {
      print(value?.data);
      emit(RegisterSuccessState());
    }).catchError((error) {
      if (error is DioException) {
        print(error.response?.data);
      }
      print(error);
      emit(RegisterErrorState());
      throw error;
    });
  }
}
