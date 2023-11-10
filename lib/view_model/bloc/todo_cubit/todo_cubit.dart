import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:todo_app/view_model/bloc/todo_cubit/todo_states.dart';
import 'package:todo_app/view_model/data/local/shared_keys.dart';
import 'package:todo_app/view_model/data/local/shared_prefernce.dart';
import 'package:todo_app/view_model/data/network/dio_helper.dart';
import 'package:todo_app/view_model/data/network/end_points.dart';
import 'package:todo_app/view_model/utils/functions.dart';
import '../../../model/statistics_madel.dart';
import '../../../model/task_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToDoCubit extends Cubit<ToDoStates> {
  ToDoCubit() : super(ToDoInitialState());

  int currentIndex = 0;

  ToDoModel? todoModel;

  StatisticsModel? statistics;

  XFile? image;

  static ToDoCubit get(context) => BlocProvider.of<ToDoCubit>(context);

  var titleController = TextEditingController();
  var detailsController = TextEditingController();
  var startDateController = TextEditingController();
  var endDateController = TextEditingController();

  var editTitleController = TextEditingController();
  var editDetailsController = TextEditingController();
  var editStartDateController = TextEditingController();
  var editEndDateController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  var editFormKey = GlobalKey<FormState>();

  void changeIndex(int index){
    currentIndex=index;
    setData();
  }

  Future<void> getAllTasks() async {
    //print(LocalData.get(key: SharedKeys.token));
    emit(GetAllTasksLoadingState());
    await DioHelper.get(
      endPoint: EndPoints.tasks,
      token: LocalData.get(
        key: SharedKeys.token,
      ),
    ).then((value){
      print(value?.data);
      todoModel=ToDoModel.fromJson(value?.data);
      emit(GetAllTasksSuccessState());
    }).catchError((error){
      if(error is DioException){
        print(error.response?.data);
      }
      emit(GetAllTasksErrorState());
    });
  }

  Future<void> addNewTask() async {
    emit(AddNewTaskLoadingState());
    await DioHelper.post(
      endPoint: EndPoints.tasks,
      token: LocalData.get(
        key: SharedKeys.token,
      ),
      formData: FormData.fromMap(
        {
          'title':titleController.text,
          'description':detailsController.text,
          'start_date':startDateController.text,
          'end_date':endDateController.text,
          if(image != null)'image': await MultipartFile.fromFile(image!.path),
          'status':'new',
        }
      ),
    ).then((value){
      print(value?.data);
      emit(AddNewTaskSuccessState());
      getAllTasks();
      image=null;
    }).catchError((error){
      if(error is DioException){
        print(error.response?.data);
      }
      emit(AddNewTaskErrorState());
      throw error;
    });
    clearAllData();
  }

  Future<void> updateTask() async {
    emit(UpdateTaskLoadingState());
    await DioHelper.post(
      endPoint: "${EndPoints.tasks}/${todoModel?.data?.tasks?[currentIndex].id}",
      token: LocalData.get(
        key: SharedKeys.token,
      ),
      formData: FormData.fromMap(
          {
            '_method':'PUT',
            'title':editTitleController.text,
            'description':editDetailsController.text,
            'start_date':editStartDateController.text,
            'end_date':editEndDateController.text,
            if(image != null)'image': await MultipartFile.fromFile(image!.path),
            'status':'compeleted',
          }
      ),
    ).then((value){
      print(value?.data);
      emit(UpdateTaskSuccessState());
      getAllTasks();
      image=null;
    }).catchError((error){
      if(error is DioException){
        print(error.response?.data);
      }
      emit(UpdateTaskErrorState());
      throw error;
    });
    clearAllData();
  }

  Future<void> deleteTask() async {
    emit(DeleteTaskLoadingState());
    await DioHelper.delete(
      endPoint: "${EndPoints.tasks}/${todoModel?.data?.tasks?[currentIndex].id}",
      token: LocalData.get(
        key: SharedKeys.token,
      ),
    ).then((value){
      print(value?.data);
      emit(DeleteTaskSuccessState());
      getAllTasks();
    }).catchError((error){
      if(error is DioException){
        print(error.response?.data);
      }
      emit(DeleteTaskErrorState());
      throw error;
    });
  }

  Future<void> showStatistics() async {
    //print(LocalData.get(key: SharedKeys.token));
    emit(GetStatisticsLoadingState());
    await DioHelper.get(
      endPoint: EndPoints.statistics,
      token: LocalData.get(
        key: SharedKeys.token,
      ),
    ).then((value){
      print(value?.data);
      statistics=StatisticsModel.fromJson(value?.data);
      emit(GetStatisticsSuccessState());
    }).catchError((error){
      if(error is DioException){
        print(error.response?.data);
      }
      emit(GetStatisticsErrorState());
    });
  }

  void setData() {
    editTitleController.text = todoModel?.data?.tasks?[currentIndex].title!??"";
    editDetailsController.text = todoModel?.data?.tasks?[currentIndex].description!??"";
    editStartDateController.text = todoModel?.data?.tasks?[currentIndex].startDate!??"";
    editEndDateController.text = todoModel?.data?.tasks?[currentIndex].endDate!??"";
  }

  void clearAllData() {
    titleController.clear();
    detailsController.clear();
    startDateController.clear();
    endDateController.clear();
    emit(ClearAllDataState());
  }

  void takePhotoFromUser()async{
    emit(UploadImageLoadingState());
    var status=await Permission.storage.request();
     image =await ImagePicker().pickImage(source: ImageSource.gallery);
     if(image==null){
       emit(UploadImageErrorState());
       Functions.showToast(message: "Choose an image");
       return;
     }
    emit(UploadImageSuccessState());
    if(status.isGranted){
      print('granted');
    }else{
      print('not granted');
    }
  }
}
