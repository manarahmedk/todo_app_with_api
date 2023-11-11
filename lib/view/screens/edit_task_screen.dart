import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/view/components/widgets/text_custom.dart';
import 'package:todo_app/view/screens/todo_screen.dart';
import 'package:todo_app/view_model/utils/colors.dart';
import '../../model/task_model.dart';
import '../../view_model/bloc/todo_cubit/todo_cubit.dart';
import '../../view_model/bloc/todo_cubit/todo_states.dart';
import '../../view_model/utils/functions.dart';
import '../../view_model/utils/navigation.dart';
import '../components/widgets/my_text_form_field.dart';

class EditTaskScreen extends StatelessWidget {
  Task taskModel;

  EditTaskScreen({required this.taskModel});

  @override
  Widget build(BuildContext context) {
    var cubit = ToDoCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.orange,
        title: const TextCustom(
          text: ' Edit Task ',
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
              key: cubit.editFormKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    MyTextFormField(
                      hintText: 'Title',
                      keyboardType: TextInputType.text,
                      controller: cubit.editTitleController,
                      textInputAction: TextInputAction.next,
                      prefixIcon: Icons.title_outlined,
                      validator: (value) {
                        if ((value ?? '').isEmpty) {
                          return 'Please, Enter your Task Title';
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
                      controller: cubit.editDetailsController,
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
                      controller: cubit.editStartDateController,
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
                          cubit.editStartDateController.text =
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
                      controller: cubit.editEndDateController,
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
                          cubit.editEndDateController.text =
                              "${value.year}-${value.month}-${value.day}";
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocConsumer<ToDoCubit, ToDoStates>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return InkWell(
                          onTap: () {
                            cubit.takePhotoFromUser();
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.grey,
                                width: 1,
                              ),
                            ),
                            child: Visibility(
                              visible: cubit.image == null,
                              replacement:
                                  Image.file(File(cubit.image?.path ?? '')),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if ((cubit.todoModel?.data?.tasks?[cubit.currentIndex].image ?? "").isNotEmpty)
                                    Image.network(cubit.todoModel?.data?.tasks?[cubit.currentIndex].image ?? ''),
                                  if ((cubit.todoModel?.data?.tasks?[cubit.currentIndex].image ?? "").isEmpty)
                                    ...[
                                    const Icon(
                                      Icons.image,
                                      size: 200,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const TextCustom(
                                      text: "Add Image",
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.orange,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    BlocConsumer<ToDoCubit,ToDoStates>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return Container(
                          padding: EdgeInsets.all(16),
                          child:  DropdownButtonFormField2<String>(
                            isExpanded: true,
                            decoration: InputDecoration(
                              // Add Horizontal padding using menuItemStyleData.padding so it matches
                              // the menu padding when button's width is not specified.
                              contentPadding: const EdgeInsets.symmetric(vertical: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              // Add more decoration..
                            ),
                            hint: const Text(
                              'Select Status',
                              style: TextStyle(fontSize: 14),
                            ),
                            items: cubit.statusItems.map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            )).toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select status';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              //Do something when selected item is changed.
                            },
                            onSaved: (value) {
                              cubit.statusValue = value.toString();
                            },
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.only(right: 8),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: 24,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                BlocBuilder<ToDoCubit, ToDoStates>(
                  builder: (context, state) {
                    return Visibility(
                      visible: cubit.state is UpdateTaskLoadingState,
                      child: LinearProgressIndicator(),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 350,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (cubit.editFormKey.currentState!.validate()) {
                        cubit.updateTask().then((value) {
                          Navigation.pushAndRemove(context, ToDoScreen());
                          Functions.showToast(message: "Updated Successfully");
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
                      text: 'Edit Task',
                      fontSize: 15,
                      color: AppColors.white,
                    ),
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
                      cubit.deleteTask().then((value) {
                        Functions.showToast(message: "Deleted Successfully");
                        Navigator.pop(context);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.orange,
                      minimumSize: const Size(double.infinity, 50),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    child: const TextCustom(
                      text: 'Delete Task',
                      fontSize: 15,
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
