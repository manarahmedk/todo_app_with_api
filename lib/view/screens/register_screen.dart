import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/view/components/widgets/text_custom.dart';
import 'package:todo_app/view/screens/login_screen.dart';
import 'package:todo_app/view/screens/todo_screen.dart';
import 'package:todo_app/view_model/utils/colors.dart';
import '../../view_model/bloc/auth_cubit/auth_cubit.dart';
import '../../view_model/utils/navigation.dart';
import '../components/widgets/my_text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  bool obscureText = true;

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: BlocConsumer<AuthCubit,AuthState>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit=AuthCubit.get(context);
              return ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Image.network(
                    'https://cdn.icon-icons.com/icons2/1543/PNG/512/todo_107314.png',
                    height: 200,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextCustom(
                    text: 'Register',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: cubit.formKey2,
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        MyTextFormField(
                          hintText: 'Name',
                          keyboardType: TextInputType.emailAddress,
                          controller: cubit.nameController2,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if ((value ?? '').isEmpty) {
                              return 'Please, Enter your Name';
                            }
                            return null;
                          },
                        ),
                        MyTextFormField(
                          hintText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          controller: cubit.emailController2,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if ((value ?? '').isEmpty) {
                              return 'Please, Enter your Email';
                            }
                            return null;
                          },
                        ),
                        MyTextFormField(
                          hintText: 'Password',
                          keyboardType: TextInputType.text,
                          controller: cubit.passwordController2,
                          suffixIcon: Icons.remove_red_eye,
                          obscureText: obscureText,
                          secondSuffixIcon: Icons.visibility_off,
                          validator: (value) {
                            if ((value ?? '').isEmpty) {
                              return 'Please, Enter your Password';
                            }
                            return null;
                          },
                        ),
                        MyTextFormField(
                          hintText: 'Confirm Password',
                          keyboardType: TextInputType.text,
                          controller: cubit.confirmPasswordController2,
                          suffixIcon: Icons.remove_red_eye,
                          obscureText: obscureText,
                          secondSuffixIcon: Icons.visibility_off,
                          validator: (value) {
                            if ((value ?? '').isEmpty) {
                              return 'Please, Enter your Password';
                            } else if (value !=
                                cubit.passwordController2.text) {
                              return 'Password not match';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (cubit.formKey2.currentState!.validate()) {
                          cubit.registerWithApi().then((value) {
                            Navigation.pushAndRemove(context, LoginScreen());
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.orange,
                        minimumSize: const Size(double.infinity, 50),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      child: TextCustom(
                        text: 'Register',
                        fontSize: 15,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigation.pushAndRemove(context, LoginScreen());
                        },
                        child: TextCustom(
                          text: 'Login',
                          fontSize: 17,
                          color: AppColors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
