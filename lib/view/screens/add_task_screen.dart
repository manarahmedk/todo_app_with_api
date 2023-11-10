import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/view/components/widgets/text_custom.dart';
import 'package:todo_app/view_model/bloc/todo_cubit/todo_states.dart';
import 'package:todo_app/view_model/utils/colors.dart';
import 'package:todo_app/view_model/utils/functions.dart';
import '../../view_model/bloc/todo_cubit/todo_cubit.dart';
import '../components/widgets/my_text_form_field.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = ToDoCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.orange,
        title: TextCustom(
          text: ' Add Task ',
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: AppColors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: cubit.formKey,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    MyTextFormField(
                      hintText: 'Title',
                      keyboardType: TextInputType.text,
                      controller: cubit.titleController,
                      textInputAction: TextInputAction.next,
                      prefixIcon: Icons.title_outlined,
                      validator: (value) {
                        if ((value ?? '').isEmpty) {
                          return 'Please, Enter your Task title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextFormField(
                      hintText: 'Description',
                      keyboardType: TextInputType.text,
                      controller: cubit.detailsController,
                      textInputAction: TextInputAction.next,
                      prefixIcon: Icons.description_outlined,
                      validator: (value) {
                        if ((value ?? '').isEmpty) {
                          return 'Please, Enter your Task Description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextFormField(
                      hintText: 'Start Date',
                      keyboardType: TextInputType.none,
                      controller: cubit.startDateController,
                      textInputAction: TextInputAction.next,
                      prefixIcon: Icons.timer_outlined,
                      readOnly: true,
                      validator: (value) {
                        if ((value ?? '').isEmpty) {
                          return 'Please, Enter your Task Start Date';
                        }
                        return null;
                      },
                      onTap: () async {
                        final value = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2050));
                        if (value != null) {
                          cubit.startDateController.text =
                          "${value.year}-${value.month}-${value.day}";
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextFormField(
                      hintText: 'End Date',
                      keyboardType: TextInputType.none,
                      controller: cubit.endDateController,
                      prefixIcon: Icons.timer_off_outlined,
                      readOnly: true,
                      validator: (value) {
                        if ((value ?? '').isEmpty) {
                          return 'Please, Enter your Task End Time';
                        }
                        return null;
                      },
                      onTap: () async {
                        final value = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2050));
                        if (value != null) {
                          cubit.endDateController.text =
                          "${value.year}-${value.month}-${value.day}";
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocConsumer<ToDoCubit,ToDoStates>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return InkWell(
                          onTap: () {
                            cubit.takePhotoFromUser();
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.grey,
                                width: 1,
                              ),
                            ),
                            child: Visibility(
                              visible: cubit.image == null,
                              replacement: Image.file(
                                File(cubit.image?.path ?? ""),),
                              child: const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.image,
                                    size: 200,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextCustom(
                                    text: "Add Image",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.orange,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Container(
                width: 350,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (cubit.formKey.currentState!.validate()) {
                      cubit.addNewTask().then((value) {
                        Navigator.pop(context);
                        Functions.showToast(message: "Added Successfully");
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
                  child: const TextCustom(
                    text: 'Add Task',
                    fontSize: 15,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
